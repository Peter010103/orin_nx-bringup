#!/bin/sh

nvidia-docker run --detach \
    --gpus all \
    --privileged \
    --net=host \
    --device=/dev/ttyTHS1 \
    --volume ${PWD}:/home/:Z \
    -it orin_drones_jammy:latest "$@"
