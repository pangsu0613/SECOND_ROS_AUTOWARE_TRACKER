; Auto-generated. Do not edit!


(cl:in-package lgsvl_msgs-msg)


;//! \htmlinclude Detection2DArray.msg.html

(cl:defclass <Detection2DArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (detections
    :reader detections
    :initarg :detections
    :type (cl:vector lgsvl_msgs-msg:Detection2D)
   :initform (cl:make-array 0 :element-type 'lgsvl_msgs-msg:Detection2D :initial-element (cl:make-instance 'lgsvl_msgs-msg:Detection2D))))
)

(cl:defclass Detection2DArray (<Detection2DArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Detection2DArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Detection2DArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lgsvl_msgs-msg:<Detection2DArray> is deprecated: use lgsvl_msgs-msg:Detection2DArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Detection2DArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:header-val is deprecated.  Use lgsvl_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'detections-val :lambda-list '(m))
(cl:defmethod detections-val ((m <Detection2DArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:detections-val is deprecated.  Use lgsvl_msgs-msg:detections instead.")
  (detections m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Detection2DArray>) ostream)
  "Serializes a message object of type '<Detection2DArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'detections))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'detections))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Detection2DArray>) istream)
  "Deserializes a message object of type '<Detection2DArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'detections) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'detections)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'lgsvl_msgs-msg:Detection2D))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Detection2DArray>)))
  "Returns string type for a message object of type '<Detection2DArray>"
  "lgsvl_msgs/Detection2DArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detection2DArray)))
  "Returns string type for a message object of type 'Detection2DArray"
  "lgsvl_msgs/Detection2DArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Detection2DArray>)))
  "Returns md5sum for a message object of type '<Detection2DArray>"
  "6104af071edb62623402eb699c3c5b70")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Detection2DArray)))
  "Returns md5sum for a message object of type 'Detection2DArray"
  "6104af071edb62623402eb699c3c5b70")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Detection2DArray>)))
  "Returns full string definition for message of type '<Detection2DArray>"
  (cl:format cl:nil "std_msgs/Header header~%Detection2D[] detections  # A list of 2D detections~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: lgsvl_msgs/Detection2D~%std_msgs/Header header~%uint32 id  # The numeric ID of the detected object~%string label  # car, pedestrian~%float32 score  # The confidence score of the detected object in the range [0-1]~%BoundingBox2D bbox  # A 2D bounding box~%geometry_msgs/Twist velocity  # Linear and angular velocity~%~%================================================================================~%MSG: lgsvl_msgs/BoundingBox2D~%float32 x  # x position of the bounding box center in camera image space, in pixels~%float32 y  # y position of the bounding box center in camera image space, in pixels~%float32 width  # width of the bounding box, in pixels~%float32 height  # height of the bounding box, in pixels~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Detection2DArray)))
  "Returns full string definition for message of type 'Detection2DArray"
  (cl:format cl:nil "std_msgs/Header header~%Detection2D[] detections  # A list of 2D detections~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: lgsvl_msgs/Detection2D~%std_msgs/Header header~%uint32 id  # The numeric ID of the detected object~%string label  # car, pedestrian~%float32 score  # The confidence score of the detected object in the range [0-1]~%BoundingBox2D bbox  # A 2D bounding box~%geometry_msgs/Twist velocity  # Linear and angular velocity~%~%================================================================================~%MSG: lgsvl_msgs/BoundingBox2D~%float32 x  # x position of the bounding box center in camera image space, in pixels~%float32 y  # y position of the bounding box center in camera image space, in pixels~%float32 width  # width of the bounding box, in pixels~%float32 height  # height of the bounding box, in pixels~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Detection2DArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'detections) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Detection2DArray>))
  "Converts a ROS message object to a list"
  (cl:list 'Detection2DArray
    (cl:cons ':header (header msg))
    (cl:cons ':detections (detections msg))
))
