
(cl:in-package :asdf)

(defsystem "lgsvl_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "BoundingBox2D" :depends-on ("_package_BoundingBox2D"))
    (:file "_package_BoundingBox2D" :depends-on ("_package"))
    (:file "BoundingBox3D" :depends-on ("_package_BoundingBox3D"))
    (:file "_package_BoundingBox3D" :depends-on ("_package"))
    (:file "Detection2D" :depends-on ("_package_Detection2D"))
    (:file "_package_Detection2D" :depends-on ("_package"))
    (:file "Detection2DArray" :depends-on ("_package_Detection2DArray"))
    (:file "_package_Detection2DArray" :depends-on ("_package"))
    (:file "Detection3D" :depends-on ("_package_Detection3D"))
    (:file "_package_Detection3D" :depends-on ("_package"))
    (:file "Detection3DArray" :depends-on ("_package_Detection3DArray"))
    (:file "_package_Detection3DArray" :depends-on ("_package"))
  ))