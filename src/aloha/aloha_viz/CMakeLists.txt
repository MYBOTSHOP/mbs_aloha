cmake_minimum_required(VERSION 3.0.2)
project(aloha_viz)

find_package(catkin REQUIRED COMPONENTS
  rviz
)

catkin_package()

include_directories(
  ${catkin_INCLUDE_DIRS}
)