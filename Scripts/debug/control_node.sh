#!/bin/sh
cd ../../
./dev.sh zsh -i -c "cd AD && source devel/setup.zsh && roslaunch control controller.launch debug_level:=2 sign:=true v:=25 dashboard:=true use_tcp:=true debug:='gdb -ex run --args'"
