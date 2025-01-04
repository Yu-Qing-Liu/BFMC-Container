#!/bin/bash
cd ..
./dev.sh bash -i -c "cd AD && catkin_make --pkg utils && catkin_make"
cd Scripts
cp ./setup.bash ../Simulator/devel/
