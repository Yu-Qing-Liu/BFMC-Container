#!/bin/bash
cd ..
./dev.sh bash -c "cd AD && source ~/.bashrc && source devel/setup.bash && roslaunch control controller.launch sign:=true v:=25 dashboard:=false"