#!/bin/sh
mkdir -p ../AD/src/perception/include/ncnn/ && mkdir -p ../AD/src/planning/include/
cd ..
./dev.sh zsh -i -c "sudo cp -r /home/trtuser/ncnn/build/install/* /home/trtuser/Repositories/ROS/AD/src/perception/include/ncnn/ && sudo cp -r /home/trtuser/vcpkg/ /home/trtuser/Repositories/ROS/AD/"
