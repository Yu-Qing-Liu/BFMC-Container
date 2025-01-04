#!/bin/bash
cd ..
./dev.sh bash -i -c "cd Simulator && source devel/setup.bash && roslaunch sim_pkg ${@:-run3.launch}"
