;; Auto-generated. Do not edit!


(when (boundp 'lgsvl_msgs::BoundingBox3D)
  (if (not (find-package "LGSVL_MSGS"))
    (make-package "LGSVL_MSGS"))
  (shadow 'BoundingBox3D (find-package "LGSVL_MSGS")))
(unless (find-package "LGSVL_MSGS::BOUNDINGBOX3D")
  (make-package "LGSVL_MSGS::BOUNDINGBOX3D"))

(in-package "ROS")
;;//! \htmlinclude BoundingBox3D.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass lgsvl_msgs::BoundingBox3D
  :super ros::object
  :slots (_position _size ))

(defmethod lgsvl_msgs::BoundingBox3D
  (:init
   (&key
    ((:position __position) (instance geometry_msgs::Pose :init))
    ((:size __size) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _position __position)
   (setq _size __size)
   self)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:size
   (&rest __size)
   (if (keywordp (car __size))
       (send* _size __size)
     (progn
       (if __size (setq _size (car __size)))
       _size)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose _position
    (send _position :serialization-length)
    ;; geometry_msgs/Vector3 _size
    (send _size :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose _position
       (send _position :serialize s)
     ;; geometry_msgs/Vector3 _size
       (send _size :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; geometry_msgs/Vector3 _size
     (send _size :deserialize buf ptr-) (incf ptr- (send _size :serialization-length))
   ;;
   self)
  )

(setf (get lgsvl_msgs::BoundingBox3D :md5sum-) "0afc39928ba33aad299a6acabb48fd7d")
(setf (get lgsvl_msgs::BoundingBox3D :datatype-) "lgsvl_msgs/BoundingBox3D")
(setf (get lgsvl_msgs::BoundingBox3D :definition-)
      "geometry_msgs/Pose position  # 3D position and orientation of the bounding box center in Lidar space, in meters
geometry_msgs/Vector3 size  # Size of the bounding box, in meters

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :lgsvl_msgs/BoundingBox3D "0afc39928ba33aad299a6acabb48fd7d")


