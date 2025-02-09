#!/bin/sh
cd ../../
./dashboard.sh zsh -i -c "cd AD && export ROS_MASTER_URI=http://10.121.105.18:11311 && source devel/setup.zsh && rosrun gui gui.py --use_tcp"
