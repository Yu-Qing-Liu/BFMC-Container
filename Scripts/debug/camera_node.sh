#!/bin/sh
cd ../../
./dev.sh zsh -i -c "cd AD && source devel/setup.zsh && roslaunch perception cameraNode_debug.launch newlane:=false use_tcp:=true"
