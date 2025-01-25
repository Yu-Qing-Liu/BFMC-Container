#!/bin/sh
cd ..
./dev.sh bash -i -c "cd AD && source devel/setup.bash && roslaunch perception cameraNode.launch newlane:=false use_tcp:=true ip:=10.121.105.18"
