#!/bin/sh
cd ..
./dev.sh zsh -i -c "cd Simulator && catkin_make --pkg utils && catkin_make"
cd Scripts
sudo cp ./setup.zsh ../Simulator/devel/
