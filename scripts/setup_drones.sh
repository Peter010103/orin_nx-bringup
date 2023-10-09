#!/bin/sh

cd /home/ubuntu/
mkdir -p ros2_drone_ws/src
cd /home/ubuntu/ros2_drone_ws/src/
git clone -b ros2-devel https://github.com/unl-nimbus-lab/Freyja.git
cp /home/ubuntu/orin-bringup/scripts/run.sh /home/ubuntu/ros2_drone_ws/

cd /home/ubuntu/orin-bringup
nvidia-docker build -t orin_drones:latest .
