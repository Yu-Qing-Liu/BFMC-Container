#!/bin/bash

mkdir -p /home/admin/Repositories/Ros/AD/src/perception/include/ncnn/
mkdir -p /home/admin/Repositories/ROS/AD/src/planning/include/
cp -r ~/ncnn/build/install/* /home/admin/Repositories/Ros/AD/src/perception/include/ncnn/
cp -r ~/vcpkg/ /home/admin/Repositories/ROS/AD/
