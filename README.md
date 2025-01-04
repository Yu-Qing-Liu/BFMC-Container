# ROS Container
```
Docker container with base ros-noetic-desktop installation and dependencies
```
```
1. git clone AD and Simulator

2. Install docker and docker compose.

3. Allow docker to use your display.

4. Install the necessary nvidia drivers for your machine.

5. Edit system variables in Dockerfile.opencv to match your machine -> CUDA_COMPUTE_CAPABILITY in the opencv section.

6. Run build.sh to build the base image which will have all dependencies installed

7. Run dev.sh to use the container. Container has a volume mounted at /AD and /Simulator so that code changes are persistent. If you change code on your machine, the container will immediately have access to the changes.

8. Navigate to the Scripts folder and run inject.sh to inject the dependencies into the project

9. You may use catkin commands manually inside the container to compile, or use the scripts in Scripts.

10. Once compiled you may use the scripts in Scripts to autorun some of the nodes/simulator/gui
```
