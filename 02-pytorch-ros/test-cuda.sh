#!/bin/bash

docker run -it --rm --runtime nvidia ros-with-cuda:arm64v8 /tmp/samples/1_Utilities/deviceQuery/devicequery
