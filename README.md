# ROS Container
```
Docker container with base ros-noetic-desktop installation and dependencies
```
```
0. git clone AD and Simulator

1. download TensorRT tar file as well as Acados zip file (google drive) and place it in the root directory (same dir as the dockerfiles)

2. Install docker and docker compose.

3. Allow docker to use your display.

4. Install the necessary nvidia drivers for your machine.

5. Edit system variables in Dockerfile to match your machine, like CUDA_COMPUTE_CAPABILITY in the opencv section.

6. Run dependencies.sh to build the base image which will have all dependencies installed

7. Run dev.sh each time you change the code. (It will copy AD/ and Simulator/ into the container and build the code.)

8. Run dockertty.sh to "ssh" into the dev container to run executables.
