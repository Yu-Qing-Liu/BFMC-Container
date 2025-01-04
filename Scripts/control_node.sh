#!/bin/bash
cd ..
./dev.sh bash -i -c "cd AD && source devel/setup.bash && roslaunch control controller.launch sign:=true v:=25 dashboard:=false"
