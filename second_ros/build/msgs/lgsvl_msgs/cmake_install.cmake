# Install script for directory: /home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/xi/catkin_ws_second_detecter_tracker/second_ros/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lgsvl_msgs/msg" TYPE FILE FILES
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/msg/Detection3DArray.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/msg/Detection3D.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/msg/BoundingBox3D.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/msg/Detection2DArray.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/msg/Detection2D.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/msg/BoundingBox2D.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lgsvl_msgs/cmake" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/lgsvl_msgs/catkin_generated/installspace/lgsvl_msgs-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/include/lgsvl_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/share/roseus/ros/lgsvl_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/share/common-lisp/ros/lgsvl_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/share/gennodejs/ros/lgsvl_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/lib/python2.7/dist-packages/lgsvl_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/lib/python2.7/dist-packages/lgsvl_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/lgsvl_msgs/catkin_generated/installspace/lgsvl_msgs.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lgsvl_msgs/cmake" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/lgsvl_msgs/catkin_generated/installspace/lgsvl_msgs-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lgsvl_msgs/cmake" TYPE FILE FILES
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/lgsvl_msgs/catkin_generated/installspace/lgsvl_msgsConfig.cmake"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/lgsvl_msgs/catkin_generated/installspace/lgsvl_msgsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lgsvl_msgs" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/lgsvl_msgs/package.xml")
endif()

