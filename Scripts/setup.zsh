#!/usr/bin/env zsh
# generated from catkin/cmake/templates/setup.zsh.in

CATKIN_SHELL=zsh

export GAZEBO_MODEL_PATH="/home/admin/Repositories/ROS/Simulator/src/models_pkg:$GAZEBO_MODEL_PATH"
export ROS_PACKAGE_PATH="/home/admin/Repositories/ROS/Simulator/src:$ROS_PACKAGE_PATH"

# source setup.sh from same directory as this file
_CATKIN_SETUP_DIR=$(builtin cd -q "`dirname "$0"`" > /dev/null && pwd)
emulate -R zsh -c 'source "$_CATKIN_SETUP_DIR/setup.sh"'
