#!/bin/sh
cd ../../
./dev.sh zsh -i -c "cd AD && source devel/setup.zsh && rosrun planning path2.py"
