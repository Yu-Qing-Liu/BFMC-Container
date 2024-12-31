#!/bin/bash

mkdir -p /AD/src/perception/include/ncnn
mkdir -p /AD/src/planning/include
cp -r ~/ncnn/build/install/* /AD/src/perception/include/ncnn/
cp -r ~/vcpkg/ /AD/
