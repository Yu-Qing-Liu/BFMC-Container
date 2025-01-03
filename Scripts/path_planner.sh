#!/bin/bash
cd ..
./dev.sh bash -c "cd AD && source devel/setup.bash && rosrun planning path2.py"
