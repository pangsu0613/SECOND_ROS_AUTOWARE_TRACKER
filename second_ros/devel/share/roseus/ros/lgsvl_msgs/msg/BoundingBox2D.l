;; Auto-generated. Do not edit!


(when (boundp 'lgsvl_msgs::BoundingBox2D)
  (if (not (find-package "LGSVL_MSGS"))
    (make-package "LGSVL_MSGS"))
  (shadow 'BoundingBox2D (find-package "LGSVL_MSGS")))
(unless (find-package "LGSVL_MSGS::BOUNDINGBOX2D")
  (make-package "LGSVL_MSGS::BOUNDINGBOX2D"))

(in-package "ROS")
;;//! \htmlinclude BoundingBox2D.msg.html


(defclass lgsvl_msgs::BoundingBox2D
  :super ros::object
  :slots (_x _y _width _height ))

(defmethod lgsvl_msgs::BoundingBox2D
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:width __width) 0.0)
    ((:height __height) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _width (float __width))
   (setq _height (float __height))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _width
    4
    ;; float32 _height
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _height
       (sys::poke _height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _height
     (setq _height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get lgsvl_msgs::BoundingBox2D :md5sum-) "a91ecea8870c8dcc4ddb26473f3471a8")
(setf (get lgsvl_msgs::BoundingBox2D :datatype-) "lgsvl_msgs/BoundingBox2D")
(setf (get lgsvl_msgs::BoundingBox2D :definition-)
      "float32 x  # x position of the bounding box center in camera image space, in pixels
float32 y  # y position of the bounding box center in camera image space, in pixels
float32 width  # width of the bounding box, in pixels
float32 height  # height of the bounding box, in pixels

")



(provide :lgsvl_msgs/BoundingBox2D "a91ecea8870c8dcc4ddb26473f3471a8")


