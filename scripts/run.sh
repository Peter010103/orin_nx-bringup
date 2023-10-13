#!/bin/bash

# Set your image name and container name
IMAGE_NAME="orin_drones:latest"
CONTAINER_NAME="orin_drones"

# Function to start an existing container and execute a bash interface
start_existing_container() {
  if [[ "$(docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.ID}}")" ]]; then
    echo "Starting existing container $CONTAINER_NAME..."
    nvidia-docker start $CONTAINER_NAME
    nvidia-docker exec -it $CONTAINER_NAME bash
  else
    echo "No existing container found with name $CONTAINER_NAME."
  fi
}

# Check if the container exists and start or create it
if [[ "$(docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.ID}}")" ]]; then
  start_existing_container
else
  nvidia-docker run --detach \
    --gpus all \
    --privileged \
    --net=host \
    --device=/dev/ttyTHS1 \
    --volume ${PWD}:/home/:Z \
    --name $CONTAINER_NAME \
    -it $IMAGE_NAME
fi
