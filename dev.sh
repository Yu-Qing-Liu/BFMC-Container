#!/bin/bash

# Container name (you can change this to any name you prefer)
CONTAINER_NAME="ros-container"
PLATFORM="linux/amd64"
# Function to run the Docker container with the given parameters
run_container() {
    docker run -it --name ${CONTAINER_NAME} \
        --user=1000:1000 \
        --platform ${PLATFORM} \
        --net=host \
        --gpus all \
        --env=NVIDIA_DRIVER_CAPABILITIES=all \
        --env=DISPLAY=unix$DISPLAY \
        --env=XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
        --env=WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
        --env=QT_X11_NO_MITSHM=1 \
        --device=/dev/dri:/dev/dri \
        --volume=/run/user/1000:/run/user/1000 \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume=.:/home/admin/Repositories/ROS \
        --workdir=/home/admin/Repositories/ROS \
        ad-dev \
        "${@:-bash}"
}
# Check if the container is running
if [[ $(docker ps -q -f name=${CONTAINER_NAME}) ]]; then
    # If the container is already running, use exec to enter the container
    docker exec -it ${CONTAINER_NAME} "${@:-bash}"
elif [[ $(docker ps -aq -f name=${CONTAINER_NAME}) ]]; then
    # If the container exists but is stopped, remove it
    docker rm ${CONTAINER_NAME}
    # Now, start a new container with the given name
    run_container "$@"
else
    # If the container does not exist, start it as a new one
    run_container "$@"
fi
