#!/bin/sh
cd ..
./dev.sh zsh -i -c "cd Simulator && source devel/setup.zsh && roslaunch sim_pkg ${@:-run3.launch}"
