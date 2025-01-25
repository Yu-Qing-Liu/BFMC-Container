#!/bin/sh
cd ..
./dev.sh bash -i -c "cd AD && source devel/setup.bash && roslaunch control controller.launch debug_level:=2 sign:=true v:=25 dashboard:=true use_tcp:=true ip:=10.121.105.18"
