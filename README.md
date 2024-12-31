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

6. Run build.sh to build the base image which will have all dependencies installed

7. Run dev.sh to use the container. Container has a volume mounted at /AD and /Simulator so that code changes are persistent. If you change code on your machine, the container will immediately have access to the changes.

8. Run source ~/.bashrc to export all the environment variables (inside the container)

9. Compile and run code in container and enjoy :)
