#!/bin/bash

# Run the container with NVIDIA runtime and XWayland enabled
docker run -it \
  --gpus all \
  --env=NVIDIA_DRIVER_CAPABILITIES=all \
  --env=DISPLAY=${DISPLAY} \
  --env=XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
  --env=WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
  --env=QT_X11_NO_MITSHM=${QT_X11_NO_MITSHM} \
  --device=/dev/dri:/dev/dri \
  --volume=/run/user/1000:/run/user/1000 \
  --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
  --volume=./AD:/AD \
  --volume=./Simulator:/Simulator \
  ros-ubuntu \
  bash
