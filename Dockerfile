# This is an auto generated Dockerfile for ros:desktop
# generated from docker_images_ros2/create_ros_image.Dockerfile.em
FROM ros:humble-ros-core-jammy

ARG DEBIAN_FRONTEND=noninteractive

# RUN apt update && apt install -y autoconf bc build-essential g++-8 gcc-8 clang-8 lld-8 gettext-base gfortran-8 iputils-ping libbz2-dev libc++-dev libcgal-dev libffi-dev libfreetype6-dev libhdf5-dev libjpeg-dev liblzma-dev libncurses5-dev libncursesw5-dev libpng-dev libreadline-dev libssl-dev libsqlite3-dev libxml2-dev libxslt-dev locales moreutils openssl python-openssl rsync scons python3-pip libopenblas-dev vim python3-wstool;

RUN apt update && apt install -y python3 python3-pip python3-colcon-common-extensions vim

ARG PIP_NO_CACHE_DIR=1

# Install pip dependencies
RUN pip3 install future pymavlink pyserial

# Additional ros packages
RUN apt install -y ros-humble-mavros ros-humble-mavros-extras ros-humble-mavros-msgs ros-humble-tf2-tools ros-humble-tf-transformations ros-humble-tf2-geometry-msgs

RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && chmod a+x install_geographiclib_datasets.sh
RUN ./install_geographiclib_datasets.sh

WORKDIR /home


