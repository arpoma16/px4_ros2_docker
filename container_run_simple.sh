#!/bin/bash

export CONTAINER_NAME="ros2_gz_cont"
export IMAGE_NAME="ros2_gz"


xhost +local:docker;

PROJECT_DIR="${HOME}/work/px4_volume";
PROJECT_DIST="/home/grvc/ros2_ws/src/external";

if [ "$(docker ps -qaf name=$CONTAINER_NAME)" = "" ]; then
    echo 'Container not found, creating it ...';

    docker run -it \
    --name $CONTAINER_NAME \
    --privileged \
    --workdir $PROJECT_DIST \
    --env DISPLAY=$DISPLAY \
    --network host \
    --ipc=host \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
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
    echo 'ros2_gz_cont found and running, executing a shell ...';
    docker exec -it $CONTAINER_NAME bash --login;
fi;