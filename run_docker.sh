#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # Path to shared folder
xhost +si:localuser:root  # Limits access to root user only for security

docker run --gpus all \
    -ti --rm \
    -e "DISPLAY=$DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e XAUTHORITY \
    -v $HOME/.Xauthority:/root/.Xauthority \
    -v /dev:/dev \
    -v $ROOT_DIR/ros2_ws:/ros2_ws \
    --net=host \
    --privileged \
    --name ur3e_docker \
    --memory="8g" \
    --memory-swap="12g" \
    ur3e_docker:latest
