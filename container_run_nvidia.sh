#!/bin/bash

export CONTAINER_NAME="px4_ros2_cont"
export IMAGE_NAME="px4-ros2:v1.0"

#export XDG_RUNTIME_DIR=/tmp/runtime-root
#mkdir -p $XDG_RUNTIME_DIR
#chmod 0700 $XDG_RUNTIME_DIR
xhost +local:root

#xhost +local:docker;

PROJECT_DIR="${HOME}/work/px4_volume";
PROJECT_DIST="/home/grvc/ros2_ws/src/external";

if [ "$(docker ps -qaf name=$CONTAINER_NAME)" = "" ]; then
    echo 'Container not found, creating it ...';

    docker run -it \
    --name $CONTAINER_NAME \
    --privileged \
    --workdir $PROJECT_DIST \
    --env DISPLAY=$DISPLAY \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --env XAUTHORITY=$XAUTHORITY \
    --volume $XAUTHORITY:$XAUTHORITY \
    --env QT_X11_NO_MITSHM=1 \
    --env NVIDIA_VISIBLE_DEVICES=all \
    --env NVIDIA_DRIVER_CAPABILITIES=all \
    --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
    --env __NV_PRIME_RENDER_OFFLOAD=1 \
    --env __GLX_VENDOR_LIBRARY_NAME=nvidia \
    --device /dev/dri:/dev/dri \
    --volume /etc/machine-id:/etc/machine-id:ro \
    --gpus all \
    --network host \
    --ipc=host \
    --mount type=bind,source=$PROJECT_DIR,destination=$PROJECT_DIST \
    $IMAGE_NAME bash;

    echo 'Container created.';
else
    if [ "${1}" = "restart" ] && ! docker stop $CONTAINER_NAME > /dev/null; then
        echo 'Error while stopping the container, exiting now ...';
        return 1;
    fi;
    if ! docker start $CONTAINER_NAME > /dev/null; then
        echo 'Error while starting the container, exiting now ...';
        return 1;
    fi;
    echo 'px4_docker found and running, executing a shell ...';
    docker exec -it $CONTAINER_NAME bash --login;
fi;