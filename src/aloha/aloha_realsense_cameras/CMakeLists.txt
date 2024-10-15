cmake_minimum_required(VERSION 3.0.2)
project(aloha_realsense_cameras)

find_package(catkin REQUIRED COMPONENTS
  realsense2_camera
)
catkin_package()
include_directories(
  ${catkin_INCLUDE_DIRS}
)