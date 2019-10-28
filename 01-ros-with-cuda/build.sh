#!/bin/bash

mkdir -p tmp/docker-build
cp -r /usr/local/cuda/samples ./tmp/docker-build

docker build --no-cache -t ros-with-cuda:arm64v8 .
