#!/bin/bash

mkdir -p src/perception/include/ncnn
mkdir -p src/planning/include
cp -r ~/ncnn/build/install/* /AD/src/perception/include/ncnn/
cp -r ~/vcpkg/ /AD/
