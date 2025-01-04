#!/bin/bash
cd ..
mkdir -p ../AD/src/perception/include/ncnn/ && mkdir -p ../AD/src/planning/include/
./dev.sh bash -i -c "cp -r /home/trtuser/ncnn/build/install/* /home/trtuser/Repositories/ROS/AD/src/perception/include/ncnn/ && cp -r /home/trtuser/vcpkg/ /home/trtuser/Repositories/ROS/AD/"
