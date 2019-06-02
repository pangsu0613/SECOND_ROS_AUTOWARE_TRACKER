#!/usr/bin/env python3.6

# -*- coding: utf-8 -*-

import rospy
import ros_numpy
from autoware_msgs.msg import DetectedObject, DetectedObjectArray
from sensor_msgs.msg import PointCloud2, PointField
import sensor_msgs.point_cloud2 as pc2
from std_msgs.msg import Header
from jsk_recognition_msgs.msg import BoundingBox, BoundingBoxArray

import sys
path_model = "/home/xi/catkin_ws/second_ros/src/second_ros/second/"
if '/opt/ros/kinetic/lib/python2.7/dist-packages' in sys.path:
    sys.path.remove('/opt/ros/kinetic/lib/python2.7/dist-packages')
sys.path.append(path_model)
#print (sys.path)

from pathlib import Path
import glob
import os
#print os.getcwd()
import time
import numpy as np
import math
import json

from second.pytorch.inference import TorchInferenceContext
import second.core.box_np_ops as box_np_ops

# map axes strings to/from tuples of inner axis, parity, repetition, frame
_AXES2TUPLE = {
    'sxyz': (0, 0, 0, 0), 'sxyx': (0, 0, 1, 0), 'sxzy': (0, 1, 0, 0),
    'sxzx': (0, 1, 1, 0), 'syzx': (1, 0, 0, 0), 'syzy': (1, 0, 1, 0),
    'syxz': (1, 1, 0, 0), 'syxy': (1, 1, 1, 0), 'szxy': (2, 0, 0, 0),
    'szxz': (2, 0, 1, 0), 'szyx': (2, 1, 0, 0), 'szyz': (2, 1, 1, 0),
    'rzyx': (0, 0, 0, 1), 'rxyx': (0, 0, 1, 1), 'ryzx': (0, 1, 0, 1),
    'rxzx': (0, 1, 1, 1), 'rxzy': (1, 0, 0, 1), 'ryzy': (1, 0, 1, 1),
    'rzxy': (1, 1, 0, 1), 'ryxy': (1, 1, 1, 1), 'ryxz': (2, 0, 0, 1),
    'rzxz': (2, 0, 1, 1), 'rxyz': (2, 1, 0, 1), 'rzyz': (2, 1, 1, 1)}
# axis sequences for Euler angles
_NEXT_AXIS = [1, 2, 0, 1]

# code from /opt/ros/kinetic/lib/python2.7/dist-packages/tf/transformations.py
def quaternion_from_euler(ai, aj, ak, axes='sxyz'):
    """Return quaternion from Euler angles and axis sequence.

    ai, aj, ak : Euler's roll, pitch and yaw angles
    axes : One of 24 axis sequences as string or encoded tuple

    >>> q = quaternion_from_euler(1, 2, 3, 'ryxz')
    >>> np.allclose(q, [0.310622, -0.718287, 0.444435, 0.435953])
    True

    """
    try:
        firstaxis, parity, repetition, frame = _AXES2TUPLE[axes.lower()]
    except (AttributeError, KeyError):
        _ = _TUPLE2AXES[axes]
        firstaxis, parity, repetition, frame = axes

    i = firstaxis
    j = _NEXT_AXIS[i+parity]
    k = _NEXT_AXIS[i-parity+1]

    if frame:
        ai, ak = ak, ai
    if parity:
        aj = -aj

    ai /= 2.0
    aj /= 2.0
    # print("ak : {}".format(type(ak)))
    ak /= 2.0
    ci = math.cos(ai)
    si = math.sin(ai)
    cj = math.cos(aj)
    sj = math.sin(aj)
    ck = math.cos(ak)
    sk = math.sin(ak)
    cc = ci*ck
    cs = ci*sk
    sc = si*ck
    ss = si*sk

    quaternion = np.empty((4, ), dtype=np.float64)
    if repetition:
        quaternion[i] = cj*(cs + sc)
        quaternion[j] = sj*(cc + ss)
        quaternion[k] = sj*(cs - sc)
        quaternion[3] = cj*(cc - ss)
    else:
        quaternion[i] = cj*sc - sj*cs
        quaternion[j] = cj*ss + sj*cc
        quaternion[k] = cj*cs - sj*sc
        quaternion[3] = cj*cc + sj*ss
    if parity:
        quaternion[j] *= -1

    return quaternion

def kitti_anno_to_corners(info, annos=None):
    rect = info['calib/R0_rect']
    P2 = info['calib/P2']
    Tr_velo_to_cam = info['calib/Tr_velo_to_cam']
    if annos is None:
        annos = info['annos']
    dims = annos['dimensions']
    loc = annos['location']
    rots = annos['rotation_y']
    scores = None
    if 'score' in annos:
        scores = annos['score']
    boxes_camera = np.concatenate([loc, dims, rots[..., np.newaxis]], axis=1)
    boxes_lidar = box_np_ops.box_camera_to_lidar(boxes_camera, rect,
                                                 Tr_velo_to_cam)
    box_np_ops.change_box3d_center_(boxes_lidar, src=[0.5, 0.5, 0], dst=[0.5, 0.5, 0.5])     #pang added 02/02/2019 to make the position of the bounding boxes correct
    boxes_corners = box_np_ops.center_to_corner_box3d(
        boxes_lidar[:, :3],
        boxes_lidar[:, 3:6],
        boxes_lidar[:, 6],
        origin=[0.5, 0.5, 0],
        axis=2)
    return boxes_corners, scores, boxes_lidar

def remove_low_score(image_anno, thresh):
    img_filtered_annotations = {}
    relevant_annotation_indices = [
        i for i, s in enumerate(image_anno['score']) if s >= thresh
    ]
    for key in image_anno.keys():
        img_filtered_annotations[key] = (
            image_anno[key][relevant_annotation_indices])
    return img_filtered_annotations

class Settings:
    def __init__(self, cfg_path):
        self._cfg_path = cfg_path
        self._settings = {}
        self._setting_defaultvalue = {}
        #if not Path(self._cfg_path).exists():
            #with open(self._cfg_path, 'w') as f:
                #f.write(json.dumps(self._settings, indent=2, sort_keys=True))
        #else:
            #with open(self._cfg_path, 'r') as f:
                #self._settings = json.loads(f.read())

    def set(self, name, value):
        self._settings[name] = value
        #with open(self._cfg_path, 'w') as f:
            #f.write(json.dumps(self._settings, indent=2, sort_keys=True))

    def get(self, name, default_value=None):
        if name in self._settings:
            return self._settings[name]
        if default_value is None:
            raise ValueError("name not exist")
        return default_value

    def save(self, path):
        with open(path, 'w') as f:
            f.write(json.dumps(self._settings, indent=2, sort_keys=True))

    def load(self, path):
        with open(self._cfg_path, 'r') as f:
            self._settings = json.loads(f.read())

class Processor_ROS:
    def __init__(self, calib_path, config_path, ckpt_path):
        self.points = None

        self.json_setting = Settings(str('/home/hradt/' + ".kittiviewerrc"))
        # self.config_path = self.json_setting.get("latest_vxnet_cfg_path", "")
        self.calib_path = calib_path
        self.config_path = config_path
        self.ckpt_path = ckpt_path

        self.calib_info = None
        self.inputs = None

        self.inference_ctx = None

    def initialize(self):
        self.read_calib()
        self.build_vxnet()
        self.load_vxnet()

    def run(self, points):
        num_features = 4
        rect = self.calib_info['calib/R0_rect']
        P2 = self.calib_info['calib/P2']
        Trv2c = self.calib_info['calib/Tr_velo_to_cam']
        image_shape = self.calib_info['img_shape']
        self.points = points.reshape([-1, num_features])

        # self.points = box_np_ops.remove_outside_points(
        #             self.points, rect, Trv2c, P2, image_shape)
        # print(self.points)

        [results] = self.inference_vxnet()

        #print("result before filtering is : ", results)
        results = remove_low_score(results, 0.6)    #original is 0.5

        dt_boxes_corners, scores, dt_box_lidar = kitti_anno_to_corners(
            self.calib_info, results)
        #print("result is : ", results)
        #print("dt_box_lidar: ", dt_box_lidar)

        return dt_boxes_corners, scores, dt_box_lidar, results['name']

    def _extend_matrix(self, mat):
        mat = np.concatenate([mat, np.array([[0., 0., 0., 1.]])], axis=0)
        return mat

    def read_calib(self,
                   extend_matrix=True):
        # print(self.calib_path)
        print("Start read_calib...")
        calib_info= {'calib_path': self.calib_path}
        with open(self.calib_path, 'r') as f:
            lines = f.readlines()
        P0 = np.array(
            [float(info) for info in lines[0].split(' ')[1:13]]).reshape(
                [3, 4])
        P1 = np.array(
            [float(info) for info in lines[1].split(' ')[1:13]]).reshape(
                [3, 4])
        P2 = np.array(
            [float(info) for info in lines[2].split(' ')[1:13]]).reshape(
                [3, 4])
        P3 = np.array(
            [float(info) for info in lines[3].split(' ')[1:13]]).reshape(
                [3, 4])
        if extend_matrix:
            P0 = self._extend_matrix(P0)
            P1 = self._extend_matrix(P1)
            P2 = self._extend_matrix(P2)
            P3 = self._extend_matrix(P3)
        # calib_info['calib/P0'] = P0
        # calib_info['calib/P1'] = P1
        calib_info['calib/P2'] = P2
        # calib_info['calib/P3'] = P3
        R0_rect = np.array([
            float(info) for info in lines[4].split(' ')[1:10]
        ]).reshape([3, 3])
        if extend_matrix:
            rect_4x4 = np.zeros([4, 4], dtype=R0_rect.dtype)
            rect_4x4[3, 3] = 1.
            rect_4x4[:3, :3] = R0_rect
        else:
            rect_4x4 = R0_rect
        calib_info['calib/R0_rect'] = rect_4x4
        Tr_velo_to_cam = np.array([
            float(info) for info in lines[5].split(' ')[1:13]
        ]).reshape([3, 4])
        Tr_imu_to_velo = np.array([
            float(info) for info in lines[6].split(' ')[1:13]
        ]).reshape([3, 4])
        if extend_matrix:
            Tr_velo_to_cam = self._extend_matrix(Tr_velo_to_cam)
            Tr_imu_to_velo = self._extend_matrix(Tr_imu_to_velo)
        calib_info['calib/Tr_velo_to_cam'] = Tr_velo_to_cam
        # calib_info['calib/Tr_imu_to_velo'] = Tr_imu_to_velo
        # add image shape info for lidar point cloud preprocessing
        calib_info["img_shape"] = np.array([375, 1242]) # kitti image size: height, width
        self.calib_info = calib_info
        print("Read calib file succeeded.")

    def build_vxnet(self):
        print("Start build_vxnet...")
        self.inference_ctx = TorchInferenceContext()
        self.inference_ctx.build(self.config_path)
        self.json_setting.set("latest_vxnet_cfg_path", self.config_path)
        print("Build VoxelNet ckpt succeeded.")

    def load_vxnet(self):
        print("Start load_vxnet...")
        self.json_setting.set("latest_vxnet_ckpt_path", self.ckpt_path)
        self.inference_ctx.restore(ckpt_path)
        print("Load VoxelNet ckpt succeeded.")

    def inference_vxnet(self):
        print("Start inference_vxnet...")
        t = time.time()
        self.inputs = self.inference_ctx.get_inference_input_dict_ros(
            self.calib_info, self.points)
        print("input preparation time:", time.time() - t)
        #points_display = self.inputs["points"]

        #pub_crop.publish(points_display)

        # print("self.inputs['points'] shape: ", self.inputs["points"].shape)
        # print("self.inputs['points']: ", self.inputs["points"])

        t = time.time()
        #print("example is :",self.inputs)
        with self.inference_ctx.ctx():
            det_annos = self.inference_ctx.inference(self.inputs)
            #print("det_annos:  ",det_annos)
        print("detection time:", time.time() - t)
        return det_annos

#  /velodyne_points topic's subscriber callback function
def velo_callback(msg):
    global proc
    global seq_num
    time_start = rospy.get_rostime()
    callback_time = rospy.get_rostime() - msg.header.stamp
    callback_time_secs = callback_time.secs + callback_time.nsecs/1e9
    print("Time between message publish and callback:", callback_time_secs, "seconds")
    arr_bbox = BoundingBoxArray()
    arr_dobject = DetectedObjectArray()
    #pcl_msg = pc2.read_points(msg, skip_nans=False, field_names=("x", "y", "z","intensity","ring"))
    #pcl_msg = pc2.read_points(msg, skip_nans=False, field_names=("x", "y", "z"))
    #np_p = np.array(list(pcl_msg), dtype=np.float32)
    np_p = ros_numpy.point_cloud2.pointcloud2_to_xyz_array(msg)
    #print("np_p shape: ", np_p.shape)
    #np_p = np.delete(np_p, -1, 1)  #  delete "ring" field

    # convert to xyzi point cloud
    x = np_p[:, 0].reshape(-1)
    y = np_p[:, 1].reshape(-1)
    z = np_p[:, 2].reshape(-1)
    if np_p.shape[1] == 4: # if intensity field exists
        i = np_p[:, 3].reshape(-1)
    else:
        i = np.zeros((np_p.shape[0], 1)).reshape(-1)
    cloud = np.stack((x, y, z, i)).T
    #print("cloud[0]:",cloud[0,0])
    # start processing
    dt_boxes_corners, scores, dt_box_lidar, label = proc.run(cloud)
    #print("dt_boxes_corners :",dt_boxes_corners)

    # print(scores)
    # # field of view cut
    cond = hv_in_range(x=np_p[:, 0],
                        y=np_p[:, 1],
                        z=np_p[:, 2],
                        fov=[-90, 90],
                        fov_type='h')
    cloud_ranged = cloud[cond]
    cloud_ranged_pc2 = xyz_array_to_pointcloud2(cloud_ranged[:,:3],frame_id="velodyne")  ##pay attention here, xyz_array_to_pointcloud2 only works for nX3 array!!!
    # # print(cond.shape, np_p.shape, cloud.shape)

    #  publish to /velodyne_poitns_modified
    # publish_test(cloud_ranged, msg.header.frame_id)
    #publish_test(proc.inputs['points'][0], msg.header.frame_id)
    #print("shape for points_display", points_display[0].shape)
    #publish_test(points_display[0], msg.header.frame_id)
    label_n = []
    for la,la2 in enumerate(label):
        #print("la is:",la)
        #print("la2 is:",la2)
        if la2 == 'Car':
            label_n.append(1)
        elif la2 == 'Cyclist':
            label_n.append(2)
        elif la2 == 'Pedestrian':
            label_n.append(3)
        else:
            label_n.append(4)
    # process results
    #print("label_n is ",label_n)
    end_time_1 = rospy.get_rostime() - time_start
    end_time_1_sec = end_time_1.secs + end_time_1.nsecs/1e9
    print("end_time_1 is :",end_time_1_sec)
    segment_index = box_np_ops.points_in_rbbox(cloud, dt_box_lidar, lidar=True)
    end_time_2 = rospy.get_rostime() - time_start
    end_time_2_sec = end_time_2.secs + end_time_2.nsecs/1e9
    print("end_time_2 is :",end_time_2_sec)
    #print("shape of segment_index is",segment_index.shape)
    #print("segment_index is", segment_index)
    #print(type(cloud))
    #segment_cloud = np.matmul(cloud.T,segment_index)
    segment_cloud_agg = np.array([])
    seq_num = seq_num + 1
    if scores.size != 0:
        # print('Number of detections: ', results['name'].size)
        for i in range(scores.size):
            bbox = BoundingBox()
            dobject = DetectedObject()
            #DetectedObject, DetectedObjectArray
            #box_test = BoundingBox()
            bbox.header.frame_id = msg.header.frame_id
            dobject.header.frame_id = msg.header.frame_id
            #box_test.header.frame_id = msg.header.frame_id
            # bbox.header.stamp = rospy.Time.now()
            q = quaternion_from_euler(0,0,-float(dt_box_lidar[i][6]))
            bbox.pose.orientation.x = q[0]
            bbox.pose.orientation.y = q[1]
            bbox.pose.orientation.z = q[2]
            bbox.pose.orientation.w = q[3]
            bbox.pose.position.x = float(dt_box_lidar[i][0])
            bbox.pose.position.y = float(dt_box_lidar[i][1])
            #bbox.pose.position.z = float(dt_box_lidar[i][2]+dt_box_lidar[i][5]/2)
            bbox.pose.position.z = float(dt_box_lidar[i][2])
            bbox.dimensions.x = float(dt_box_lidar[i][3])
            bbox.dimensions.y = float(dt_box_lidar[i][4])
            bbox.dimensions.z = float(dt_box_lidar[i][5])
            bbox.label = label_n[i]
            dobject.header = msg.header
            dobject.header.seq = seq_num
            #dobject.id = i
            #dobject.header.label = label[i]
            #dobject.header.score = scores[i]
            dobject.label = label[i]
            dobject.score = 1.
            dobject.space_frame = "velodyne"
            dobject.pose = bbox.pose
            dobject.dimensions = bbox.dimensions
            segment_cloud = cloud[segment_index[:,i],:3]    #pay attention here, xyz_array_to_pointcloud2 only works for nX3 array!!!
            #print("segment_cloud",segment_cloud)
            #print("shape_segment_pc:", segment_cloud.shape)
            segment_cloud_pc2 = xyz_array_to_pointcloud2(segment_cloud)
            #segment_cloud = cloud
            #segment_cloud_pc2 = pc2.create_cloud(header=msg.header,
            #                                fields=_make_point_field(4), # 4 PointFields as channel description
            #                                points=segment_cloud)
            #dobject.pointcloud = segment_cloud_pc2
            dobject.valid = True
            #print("shape of segment_cloud",segment_cloud.shape)
            #if segment_cloud_agg.size == 0:
            #             segment_cloud_agg = segment_cloud
            #else:
            #             segment_cloud_agg = np.append(segment_cloud_agg,segment_cloud,axis=0)
            #box_test.pose.orientation.x = q[0]
            #box_test.pose.orientation.x = q[1]
            #box_test.pose.orientation.x = q[2]
            #box_test.pose.orientation.x = q[3]
            #box_test.pose.position.x = 5
            #box_test.pose.position.y = 0
            #box_test.pose.position.z = -1
            #box_test.dimensions.x = float(dt_box_lidar[i][3])
            #box_test.dimensions.y = float(dt_box_lidar[i][4])
            #box_test.dimensions.z = float(dt_box_lidar[i][5])
            arr_bbox.boxes.append(bbox)
            arr_dobject.objects.append(dobject)

    arr_bbox.header.frame_id = msg.header.frame_id
    arr_dobject.header = msg.header
    arr_dobject.header.frame_id = msg.header.frame_id
    #arr_dobject.header = msg.header.frame_id
    # arr_bbox.header.stamp = rospy.Time.now()
    #print("arr_bbox.boxes.size() : {} ".format(len(arr_bbox.boxes)))
    #if len(arr_bbox.boxes) is not 0:
        # for i in range(0, len(arr_bbox.boxes)):
        #     print("[+] [x,y,z,dx,dy,dz] : {}, {}, {}, {}, {}, {}".\
        #           format(arr_bbox.boxes[i].pose.position.x,arr_bbox.boxes[i].pose.position.y,arr_bbox.boxes[i].pose.position.z,\
        #           arr_bbox.boxes[i].dimensions.x,arr_bbox.boxes[i].dimensions.y,arr_bbox.boxes[i].dimensions.z))
        #  publish to /voxelnet_arr_bbox
    end_time_3 = rospy.get_rostime() - time_start
    end_time_3_sec = end_time_3.secs + end_time_3.nsecs/1e9
    print("end_time_3 is :",end_time_3_sec)
    pub_arr_bbox.publish(arr_bbox)
    pub_arr_dobject.publish(arr_dobject)
    pub_ranged_cloud.publish(cloud_ranged_pc2)
    #print("size of segment_cloud_agg",segment)
    #publish_segment(segment_cloud_agg,msg.header.frame_id)
        #pub_test_box.publish(box_test)
        #arr_bbox.boxes.clear()
    arr_bbox.boxes = []
    arr_dobject.objects = []

def xyz_array_to_pointcloud2(points, stamp=None, frame_id=None):
    '''
    Create a sensor_msgs.PointCloud2 from an array
    of points.
    '''
    msg = PointCloud2()
    if stamp:
        msg.header.stamp = stamp
    if frame_id:
        msg.header.frame_id = frame_id
    if len(points.shape) == 3:
        msg.height = points.shape[1]
        msg.width = points.shape[0]
    else:
        msg.height = 1
        msg.width = len(points)
    msg.fields = [
        PointField('x', 0, PointField.FLOAT32, 1),
        PointField('y', 4, PointField.FLOAT32, 1),
        PointField('z', 8, PointField.FLOAT32, 1)]
    msg.is_bigendian = False
    msg.point_step = 12
    msg.row_step = 12*points.shape[0]
    msg.is_dense = int(np.isfinite(points).all())
    msg.data = np.asarray(points, np.float32).tostring()

    return msg



#  publishing function for DEBUG
def publish_test(cloud, frame_id):
    header = Header()
    header.stamp = rospy.Time()
    header.frame_id = frame_id

    # point cloud segments
    msg_segment = pc2.create_cloud(header=header,
                                    fields=_make_point_field(4), # 4 PointFields as channel description
                                    points=cloud)

    #  publish to /velodyne_points_modified
    pub_velo.publish(msg_segment) #  DEBUG

def publish_segment(cloud, frame_id):
    header = Header()
    header.stamp = rospy.Time()
    header.frame_id = frame_id

    # point cloud segments
    msg_segment = pc2.create_cloud(header=header,
                                    fields=_make_point_field(4), # 4 PointFields as channel description
                                    points=cloud)

    #  publish to /velodyne_points_modified
    pub_segment.publish(msg_segment) #  DEBUG
#  code from SqueezeSeg (inspired from Durant35)
def hv_in_range(x, y, z, fov, fov_type='h'):
    """
    Extract filtered in-range velodyne coordinates based on azimuth & elevation angle limit

    Args:
    `x`:velodyne points x array
    `y`:velodyne points y array
    `z`:velodyne points z array
    `fov`:a two element list, e.g.[-45,45]
    `fov_type`:the fov type, could be `h` or 'v',defualt in `h`

    Return:
    `cond`:condition of points within fov or not

    Raise:
    `NameError`:"fov type must be set between 'h' and 'v' "
    """
    d = np.sqrt(x ** 2 + y ** 2 + z ** 2)
    if fov_type == 'h':
        return np.logical_and(np.arctan2(y, x) > (-fov[1] * np.pi/180), np.arctan2(y, x) < (-fov[0] * np.pi/180))
    elif fov_type == 'v':
        return np.logical_and(np.arctan2(z, d) < (fov[1] * np.pi / 180), np.arctan2(z, d) > (fov[0] * np.pi / 180))
    else:
        raise NameError("fov type must be set between 'h' and 'v' ")

def _make_point_field(num_field):
    msg_pf1 = pc2.PointField()
    msg_pf1.name = np.str('x')
    msg_pf1.offset = np.uint32(0)
    msg_pf1.datatype = np.uint8(7)
    msg_pf1.count = np.uint32(1)

    msg_pf2 = pc2.PointField()
    msg_pf2.name = np.str('y')
    msg_pf2.offset = np.uint32(4)
    msg_pf2.datatype = np.uint8(7)
    msg_pf2.count = np.uint32(1)

    msg_pf3 = pc2.PointField()
    msg_pf3.name = np.str('z')
    msg_pf3.offset = np.uint32(8)
    msg_pf3.datatype = np.uint8(7)
    msg_pf3.count = np.uint32(1)

    msg_pf4 = pc2.PointField()
    msg_pf4.name = np.str('intensity')
    msg_pf4.offset = np.uint32(16)
    msg_pf4.datatype = np.uint8(7)
    msg_pf4.count = np.uint32(1)

    if num_field == 4:
        return [msg_pf1, msg_pf2, msg_pf3, msg_pf4]

    msg_pf5 = pc2.PointField()
    msg_pf5.name = np.str('label')
    msg_pf5.offset = np.uint32(20)
    msg_pf5.datatype = np.uint8(4)
    msg_pf5.count = np.uint32(1)

    return [msg_pf1, msg_pf2, msg_pf3, msg_pf4, msg_pf5]

if __name__ == '__main__':
    global proc
    global seq_num
    seq_num = 1
    #save_model_dir = os.path.join('../voxelnet/save_model', args.tag)
    save_model_dir = os.path.join(path_model + '/save_model', 'pre_trained_car')
    # initializing second
    #calib_path = '/home/hradt/shared_dir/kitti/object/training/calib/000000.txt'
    #config_path = '/home/hradt/VoxelNet/catkin_ws/src/second_ros/second/second/configs/car.config'
    #ckpt_path = '/home/hradt/VoxelNet/catkin_ws/src/second_ros/second/pretrained_models/car/voxelnet-204270.tckpt'
    #calib_path = '/home/xi/KITTI_DATASET_ROOT/training/calib/000000.txt'
    #config_path = '/home/xi/catkin_ws/second_ros/src/second_ros/second/second/configs/car.fhd.config'
    #ckpt_path = '/home/xi/catkin_ws/second_ros/src/second/pretrained_models/car/voxelnet-204270.tckpt'
    #calib_path = '/home/xi/KITTI_DATASET_ROOT/training/calib/000000.txt'
    calib_path = '/home/xi/000000.txt'
    config_path = '/home/xi/catkin_ws/second_ros/src/second_ros/second/second/configs/all.fhd_new.config'
    #ckpt_path = '/home/xi/model_dir_3/voxelnet-30950.tckpt'
    #ckpt_path = '/home/xi/model_train_all_02052019/voxelnet-74240.tckpt'
    ckpt_path = '/home/xi/model_train_all_02052019/voxelnet-74240.tckpt'
    #ckpt_path = '/home/xi/model_trainval_02042019/voxelnet-30950.tckpt'
    proc = Processor_ROS(calib_path, config_path, ckpt_path)
    proc.initialize()

    # code added for using ROS
    rospy.init_node('second_ros_node')

    # subscriber
    sub_ = rospy.Subscriber("/kitti/velo/pointcloud", PointCloud2, velo_callback, queue_size=1,buff_size=2**30)
    #sub_ = rospy.Subscriber("/os1_node/points", PointCloud2, velo_callback, queue_size=1,buff_size=2**30)
    #sub_ = rospy.Subscriber("/points_raw", PointCloud2, velo_callback, queue_size=1,buff_size=2**30)

    # publisher
    pub_velo = rospy.Publisher("velodyne_points_modified", PointCloud2, queue_size=1)
    pub_segment = rospy.Publisher("segment_points", PointCloud2, queue_size = 1)
    pub_arr_dobject = rospy.Publisher("/detection/lidar_detector/objects",DetectedObjectArray,queue_size = 1)
    #pub_crop = rospy.Publisher("velodyne_points_crop", PointCloud2, queue_size=1)
    pub_arr_bbox = rospy.Publisher("second_arr_bbox", BoundingBoxArray, queue_size=1)
    pub_ranged_cloud = rospy.Publisher("ranged_cloud",PointCloud2,queue_size=1)
    #pub_test_box = rospy.Publisher("box_test", BoundingBox, queue_size=1)
    #pub_bbox = rospy.Publisher("voxelnet_bbox", BoundingBox, queue_size=1)

    print("[+] second_ros_node has started!")
    rospy.spin()
