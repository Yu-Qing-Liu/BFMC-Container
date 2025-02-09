#!/bin/sh

# Container name (you can change this to any name you prefer)
CONTAINER_NAME="bfmc-dashboard"
PLATFORM="linux/amd64"
# Function to run the Docker container with the given parameters
run_container() {
    docker run -it --name ${CONTAINER_NAME} \
        --user=1000:1000 \
        --platform ${PLATFORM} \
        --net=bridge \
        -p 49153:49153 \
        -p 49154:49154/udp \
        -p 11311:11311 \
        --device nvidia.com/gpu=all \
        --env=NVIDIA_DRIVER_CAPABILITIES=all \
        --env=DISPLAY=$DISPLAY \
        --env=XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
        --env=WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
        --env=QT_X11_NO_MITSHM=1 \
        --device=/dev/dri:/dev/dri \
        --volume=/run/user/1000:/run/user/1000 \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume=./.local:/home/trtuser/.local \
        --volume=./.dotfiles/dev/nvim:/home/trtuser/.config/nvim \
        --volume=./.dotfiles/dev/ranger:/home/trtuser/.config/ranger \
        --volume=./.dotfiles/dev/zsh:/home/trtuser/.oh-my-zsh/themes \
        --volume=./.ros:/home/trtuser/.ros \
        --volume=.:/home/trtuser/Repositories/ROS \
        --workdir=/home/trtuser/Repositories/ROS \
        ad-dev \
        "${@:-zsh}"
}
# Check if the container is running
if [[ $(docker ps -q -f name=${CONTAINER_NAME}) ]]; then
    # If the container is already running, use exec to enter the container
    docker exec -it ${CONTAINER_NAME} "${@:-zsh}"
elif [[ $(docker ps -aq -f name=${CONTAINER_NAME}) ]]; then
    # If the container exists but is stopped, remove it
    docker rm ${CONTAINER_NAME}
    # Now, start a new container with the given name
    run_container "$@"
else
    # If the container does not exist, start it as a new one
    run_container "$@"
fi
