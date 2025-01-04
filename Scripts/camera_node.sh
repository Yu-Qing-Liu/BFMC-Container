#!/bin/bash
cd ..
./dev.sh bash -c "cd AD && source ~/.bashrc && source devel/setup.bash && roslaunch perception cameraNode.launch newlane:=false"
