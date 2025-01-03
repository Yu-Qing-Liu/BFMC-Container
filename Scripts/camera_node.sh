#!/bin/bash
cd ..
./dev.sh bash -c "cd AD && source devel/setup.bash && roslaunch perception cameraNode.launch newlande:=false"
