ARG CUDA_VERSION=11.8.0

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04
LABEL maintainer="NVIDIA CORPORATION"

ENV DEBIAN_FRONTEND=noninteractive

ENV NV_CUDNN_VERSION=8.9.6.50
ENV NV_CUDNN_PACKAGE_NAME="libcudnn8"

ENV CUDA_VERSION_MAJOR_MINOR=11.8

ENV NV_CUDNN_PACKAGE="libcudnn8=$NV_CUDNN_VERSION-1+cuda${CUDA_VERSION_MAJOR_MINOR}"
ENV NV_CUDNN_PACKAGE_DEV="libcudnn8-dev=$NV_CUDNN_VERSION-1+cuda${CUDA_VERSION_MAJOR_MINOR}"

ENV TRT_VERSION=8.6.1.6
SHELL ["/bin/bash", "-c"]

######################
# .zip(s)
######################
COPY . .

######################
# apt-get Dependencies
######################
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    autoconf \
    libudev-dev \
    wget \
    git \
    pkg-config \
    sudo \
    ssh \
    pbzip2 \
    pv \
    bzip2 \
    zip \
    unzip \
    devscripts \
    lintian \
    fakeroot \
    dh-make \
    build-essential \
    cmake \
    libgtk-3-dev \
    libglfw3-dev \
    curl \
    python3 \
    python3-pip \
    python3-dev \
    python3-wheel \
    ca-certificates \
    udev \
    yasm \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavformat-dev \
    libpq-dev \
    libxine2-dev \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libavcodec-dev \
    libavutil-dev \
    libpostproc-dev \
    libeigen3-dev \
    libgtk2.0-dev \
    python3-numpy \
    locales \
    lsb-release \
    nlohmann-json3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    ${NV_CUDNN_PACKAGE} \
    ${NV_CUDNN_PACKAGE_DEV} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME}

# Create symbolic links for python and pip
RUN cd /usr/local/bin && \
    ln -s /usr/bin/python3 python && \
    ln -s /usr/bin/pip3 pip;

###########
# TENSOR_RT
###########
RUN tar -xzvf TensorRT-8.6.1.6.Linux.x86_64-gnu.cuda-11.8.tar.gz \
    && cp -a TensorRT-8.6.1.6/lib/*.so* /usr/lib/x86_64-linux-gnu \
    && pip install TensorRT-8.6.1.6/python/tensorrt-*-cp38-none-linux_x86_64.whl

# Download NGC client
RUN cd /usr/local/bin && wget https://ngc.nvidia.com/downloads/ngccli_cat_linux.zip && unzip ngccli_cat_linux.zip && chmod u+x ngc-cli/ngc && rm ngccli_cat_linux.zip ngc-cli.md5 && echo "no-apikey\nascii\n" | ngc-cli/ngc config set

# Set environment and working directory
ENV TRT_LIBPATH=/usr/lib/x86_64-linux-gnu
ENV TRT_OSSPATH=/TensorRT
ENV PATH="/TensorRT/build/out:${PATH}:/usr/local/bin/ngc-cli"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${TRT_OSSPATH}/build/out:${TRT_LIBPATH}"

############
# ROS Noetic
############
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - && \
    apt update && \
    apt-get install -y ros-noetic-desktop-full && \
    apt-get install -y ros-noetic-robot-localization && \
    apt-get install -y ros-noetic-ackermann-msgs

RUN apt-get install -y python3-rosdep
 
RUN rosdep init && \
    rosdep fix-permissions && \
    rosdep update

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

#################
# Python packages
#################
RUN pip install -r requirements.txt

#########
# OPEN_CV
#########
ARG OPENCV_VERSION=4.10.0
# Look for your gpu model at https://developer.nvidia.com/cuda-gpus
# For reference Yu's gpu is the NVIDIA GeForce GTX 1650 Ti Mobile with a compute capability of 7.5. Set the cmake flag CUDA_ARCH_BIN to this value (your value for your gpu).
ARG CUDA_COMPUTE_CAPABILITY=7.5

RUN cd /opt/ &&\
    # Download and unzip OpenCV and opencv_contrib and delte zip files
    wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip &&\
    unzip $OPENCV_VERSION.zip &&\
    rm $OPENCV_VERSION.zip &&\
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip &&\
    unzip ${OPENCV_VERSION}.zip &&\
    rm ${OPENCV_VERSION}.zip &&\
    # Create build folder and switch to it
    mkdir /opt/opencv-${OPENCV_VERSION}/build && cd /opt/opencv-${OPENCV_VERSION}/build &&\
    # Cmake configure
    cmake \
        -DOPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
        -DWITH_CUDA=ON \
        -DCUDA_ARCH_BIN=${CUDA_COMPUTE_CAPABILITY} \
        -DCMAKE_BUILD_TYPE=RELEASE \
        # Install path will be /usr/local/lib (lib is implicit)
        -DCMAKE_INSTALL_PREFIX=/usr/local \
        .. &&\
    # Make
    make -j "$(nproc)" && \
    # Install to /usr/local/lib
    make install && \
    ldconfig &&\
    # Remove OpenCV sources and build folder
    rm -rf /opt/opencv-${OPENCV_VERSION} && rm -rf /opt/opencv_contrib-${OPENCV_VERSION}

###################
# VCPKG & Realsense
###################
RUN git clone https://github.com/Microsoft/vcpkg.git && \
    cd vcpkg && \
    ./bootstrap-vcpkg.sh && \
    ./vcpkg integrate install && \
    ./vcpkg install realsense2 && \
    cd /

############
# Acados
############
RUN unzip acados.zip && \
    cd acados && \
    rm -rf build && \
    mkdir -p build && \
    cd build && \
    cmake .. -DACADOS_WITH_QPOASES=ON -DACADOS_EXAMPLES=ON -DHPIPM_TARGET=GENERIC -DBLASFEO_TARGET=GENERIC && \
    sed -i 's/^BLASFEO_TARGET = .*/BLASFEO_TARGET = GENERIC/' /acados/Makefile.rule && \
    sed -i 's/^ACADOS_WITH_QPOASES = .*/ACADOS_WITH_QPOASES = 1/' /acados/Makefile.rule && \
    make -j "$(nproc)" && \
    make install && \
    cd .. && \
    make shared_library && \
    pip3 install -e /acados/interfaces/acados_template && \
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/acados/lib"' >> ~/.bashrc && \
    echo 'export ACADOS_SOURCE_DIR="/acados"' >> ~/.bashrc && \
    cd /

##########
# ncnn
##########
RUN git clone https://github.com/Tencent/ncnn.git && \
    cd ncnn && \
    git submodule update --init && \
    mkdir -p build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DNCNN_VULKAN=ON -DNCNN_SYSTEM_GLSLANG=ON -DNCNN_BUILD_EXAMPLES=ON .. && \
    make -j "$(nproc)" && \
    make install

###################################
# Inject dependencies into project
###################################
WORKDIR /AD
RUN mkdir -p src/perception/include/ncnn && \
    mkdir -p src/planning/include && \
    cp -r /ncnn/build/install/* src/perception/include/ncnn && \
    cp -r /vcpkg/ ~/ && \
    cp -r /TensorRT-8.6.1.6/ ~/

##########
# CLEAN UP
##########
WORKDIR /
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /*.gz
RUN rm -rf /*.zip
RUN rm -rf /vcpkg
RUN rm -rf /ncnn
RUN rm -rf /TensorRT-8.6.1.6
