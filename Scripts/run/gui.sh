#!/bin/sh
cd ../../
./dashboard.sh zsh -i -c "cd AD && source devel/setup.zsh && roscore & rosrun gui gui.py --use_tcp"
