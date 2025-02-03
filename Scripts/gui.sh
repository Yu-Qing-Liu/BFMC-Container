#!/bin/sh
cd ..
./dev.sh zsh -i -c "cd AD && source devel/setup.zsh && rosrun gui gui.py --use_tcp"
