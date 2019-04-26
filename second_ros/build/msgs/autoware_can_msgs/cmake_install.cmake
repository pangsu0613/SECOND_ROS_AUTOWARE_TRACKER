# Install script for directory: /home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/autoware_can_msgs

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/autoware_can_msgs/msg" TYPE FILE FILES
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/autoware_can_msgs/msg/CANInfo.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/autoware_can_msgs/msg/CANData.msg"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/autoware_can_msgs/msg/CANPacket.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/autoware_can_msgs/cmake" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/autoware_can_msgs/catkin_generated/installspace/autoware_can_msgs-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/include/autoware_can_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/share/roseus/ros/autoware_can_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/share/common-lisp/ros/autoware_can_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/share/gennodejs/ros/autoware_can_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python" -m compileall "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/lib/python2.7/dist-packages/autoware_can_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/devel/lib/python2.7/dist-packages/autoware_can_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/autoware_can_msgs/catkin_generated/installspace/autoware_can_msgs.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/autoware_can_msgs/cmake" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/autoware_can_msgs/catkin_generated/installspace/autoware_can_msgs-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/autoware_can_msgs/cmake" TYPE FILE FILES
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/autoware_can_msgs/catkin_generated/installspace/autoware_can_msgsConfig.cmake"
    "/home/xi/catkin_ws_second_detecter_tracker/second_ros/build/msgs/autoware_can_msgs/catkin_generated/installspace/autoware_can_msgsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/autoware_can_msgs" TYPE FILE FILES "/home/xi/catkin_ws_second_detecter_tracker/second_ros/src/msgs/autoware_can_msgs/package.xml")
endif()

