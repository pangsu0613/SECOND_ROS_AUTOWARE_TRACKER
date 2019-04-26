; Auto-generated. Do not edit!


(cl:in-package lgsvl_msgs-msg)


;//! \htmlinclude Detection2D.msg.html

(cl:defclass <Detection2D> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (label
    :reader label
    :initarg :label
    :type cl:string
    :initform "")
   (score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0)
   (bbox
    :reader bbox
    :initarg :bbox
    :type lgsvl_msgs-msg:BoundingBox2D
    :initform (cl:make-instance 'lgsvl_msgs-msg:BoundingBox2D))
   (velocity
    :reader velocity
    :initarg :velocity
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist)))
)

(cl:defclass Detection2D (<Detection2D>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Detection2D>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Detection2D)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lgsvl_msgs-msg:<Detection2D> is deprecated: use lgsvl_msgs-msg:Detection2D instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Detection2D>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:header-val is deprecated.  Use lgsvl_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Detection2D>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:id-val is deprecated.  Use lgsvl_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'label-val :lambda-list '(m))
(cl:defmethod label-val ((m <Detection2D>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:label-val is deprecated.  Use lgsvl_msgs-msg:label instead.")
  (label m))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <Detection2D>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:score-val is deprecated.  Use lgsvl_msgs-msg:score instead.")
  (score m))

(cl:ensure-generic-function 'bbox-val :lambda-list '(m))
(cl:defmethod bbox-val ((m <Detection2D>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:bbox-val is deprecated.  Use lgsvl_msgs-msg:bbox instead.")
  (bbox m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <Detection2D>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lgsvl_msgs-msg:velocity-val is deprecated.  Use lgsvl_msgs-msg:velocity instead.")
  (velocity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Detection2D>) ostream)
  "Serializes a message object of type '<Detection2D>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'label))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'label))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'bbox) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Detection2D>) istream)
  "Deserializes a message object of type '<Detection2D>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'label) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'label) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'bbox) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Detection2D>)))
  "Returns string type for a message object of type '<Detection2D>"
  "lgsvl_msgs/Detection2D")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detection2D)))
  "Returns string type for a message object of type 'Detection2D"
  "lgsvl_msgs/Detection2D")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Detection2D>)))
  "Returns md5sum for a message object of type '<Detection2D>"
  "08aa7006fffc056c9c7feca0485a7d10")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Detection2D)))
  "Returns md5sum for a message object of type 'Detection2D"
  "08aa7006fffc056c9c7feca0485a7d10")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Detection2D>)))
  "Returns full string definition for message of type '<Detection2D>"
  (cl:format cl:nil "std_msgs/Header header~%uint32 id  # The numeric ID of the detected object~%string label  # car, pedestrian~%float32 score  # The confidence score of the detected object in the range [0-1]~%BoundingBox2D bbox  # A 2D bounding box~%geometry_msgs/Twist velocity  # Linear and angular velocity~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: lgsvl_msgs/BoundingBox2D~%float32 x  # x position of the bounding box center in camera image space, in pixels~%float32 y  # y position of the bounding box center in camera image space, in pixels~%float32 width  # width of the bounding box, in pixels~%float32 height  # height of the bounding box, in pixels~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Detection2D)))
  "Returns full string definition for message of type 'Detection2D"
  (cl:format cl:nil "std_msgs/Header header~%uint32 id  # The numeric ID of the detected object~%string label  # car, pedestrian~%float32 score  # The confidence score of the detected object in the range [0-1]~%BoundingBox2D bbox  # A 2D bounding box~%geometry_msgs/Twist velocity  # Linear and angular velocity~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: lgsvl_msgs/BoundingBox2D~%float32 x  # x position of the bounding box center in camera image space, in pixels~%float32 y  # y position of the bounding box center in camera image space, in pixels~%float32 width  # width of the bounding box, in pixels~%float32 height  # height of the bounding box, in pixels~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Detection2D>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:length (cl:slot-value msg 'label))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'bbox))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Detection2D>))
  "Converts a ROS message object to a list"
  (cl:list 'Detection2D
    (cl:cons ':header (header msg))
    (cl:cons ':id (id msg))
    (cl:cons ':label (label msg))
    (cl:cons ':score (score msg))
    (cl:cons ':bbox (bbox msg))
    (cl:cons ':velocity (velocity msg))
))
