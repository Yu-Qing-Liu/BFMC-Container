#!/bin/sh
mkdir -p ../AD/src/perception/include/ncnn/ && mkdir -p ../AD/src/planning/include/
cd ..
./dev.sh bash -i -c "cp -r /home/trtuser/ncnn/build/install/* /home/admin/Repositories/ROS/AD/src/perception/include/ncnn/ && cp -r /home/trtuser/vcpkg/ /home/admin/Repositories/ROS/AD/"
