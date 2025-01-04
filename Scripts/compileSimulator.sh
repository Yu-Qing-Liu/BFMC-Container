#!/bin/bash
cd ..
./dev.sh bash -i -c "cd Simulator && catkin_make --pkg utils && catkin_make"
cd Scripts
sudo cp ./setup.bash ../Simulator/devel/
