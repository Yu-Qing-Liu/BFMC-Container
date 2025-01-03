# ROS Container
```
Docker container with base ros-noetic-desktop installation and dependencies
```
```
1. git clone AD and Simulator

2. Install docker and docker compose.

3. Allow docker to use your display.

4. Install the necessary nvidia drivers for your machine.

5. Edit system variables in Dockerfile.opencv to match your machine, like CUDA_COMPUTE_CAPABILITY in the opencv section.

6. Run build.sh to build the base image which will have all dependencies installed

7. Run dev.sh to use the container. Container has a volume mounted at /AD and /Simulator so that code changes are persistent. If you change code on your machine, the container will immediately have access to the changes.

8. Run inject.sh in the container to move inject dependencies into project. 

9. Compile and run code in container and enjoy :)
```
