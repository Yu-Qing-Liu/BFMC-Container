./compileAD.sh
alacritty -e ./control_node.sh &
alacritty -e ./path_planner.sh &
./guilocalhost.sh
