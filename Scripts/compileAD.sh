#!/bin/bash
cd ..
./dev.sh bash -i -c "cd AD && catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=ON && ln -s build/compile_commands.json compile_commands.json"
