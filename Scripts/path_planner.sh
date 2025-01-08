#!/bin/sh
cd ..
./dev.sh bash -i -c "cd AD && source devel/setup.bash && rosrun planning path2.py"
