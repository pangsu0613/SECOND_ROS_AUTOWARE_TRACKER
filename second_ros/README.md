# Run SECOND as a ROS Node and publish corresponding custom ROS messages that Autoware IMM_PDA_UKF_Tracker supports

This is a modified and improved version of [second_ros](https://github.com/cedricxie/second_ros) using SECOND V1.5 model. It can achieve real time performace on 1080Ti, tested with KITTI rosbag and ouster Lidar data.

Most of the code is from
[SECOND detector](https://github.com/traveller59/second.pytorch),
[second_ros](https://github.com/cedricxie/second_ros),
[Voxelnet ROS Implementation](https://github.com/tigerk0430/voxelnet_ros).
Special thanks to [@traveller59](https://github.com/traveller59), [@qianguih](https://github.com/qianguih) and [cedricxie](https://github.com/cedricxie/second_ros)


## Instructions

### Step 1: build package
```
mkdir catkin_ws && cd catkin_ws
git clone https://github.com/cedricxie/second_ros
catkin_make && source devel/setup.bash
```

### Step 2: create environment for SECOND
Follow installation and dataset preparation instruction at https://github.com/traveller59/second.pytorch.  Notice that if you have rospy installed in Python 3, you can still use rosrun to launch SECOND as a ROS node.

```
source add_paths.sh
pip install --user rospkg catkin_pkg
```

### Step 3: launch SECOND as a ROS node
Play a rosbag in another terminal and start the ros node.
```
roslaunch second_ros second_kitt.launch
```

