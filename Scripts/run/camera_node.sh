#!/bin/sh
cd ../../
./dev.sh zsh -i -c "cd AD && source devel/setup.zsh && roslaunch perception cameraNode.launch newlane:=false use_tcp:=true ip:=172.17.0.2"
