#!/usr/bin/bash

# Check if an integer argument was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <integer>"
    exit 1
fi

# Check if the argument is a valid integer
if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Error: Argument is not an integer."
    exit 1
fi

robot_id=$1
echo "Setting up ip and directories for Robot $robot_id"

static_ip="{STATIC_IP}$robot_id/24"

sudo nmcli con add \
     con-name "{CONNECTION_NAME}" \
     type wifi \
     ifname wlan0 \
     ssid "{SSID}" \
     -- wifi-sec.key-mgmt wpa-psk \
     wifi-sec.psk "{PASSWORD}" \
     ipv4.method manual \
     ipv4.gateway "{GATEWAY}" \
     ipv4.address $static_ip \
     ipv4.dns "{NAMESERVER}" \
     ipv6.method disabled

cd /home/ubuntu/
mkdir -p ros2_drone_ws/src
cd /home/ubuntu/ros2_drone_ws/src/
git clone -b ros2-devel https://github.com/unl-nimbus-lab/Freyja.git
cp /home/ubuntu/orin-bringup/scripts/run.sh /home/ubuntu/ros2_drone_ws/

cd /home/ubuntu/orin-bringup
nvidia-docker build -t orin_drones:latest .

cd /home/ubuntu/orin-bringup/scripts/drone_configfiles/
sed -i 's/value: "U[0-9]*"/value: "U'"$robot_id"'"/' indoor_flight.launch.yaml
sed -i "s/{ *name: *\"numeric_id\", *value: *\"[0-9]*\" *}/{ name:   \"numeric_id\",           value: \"$robot_id\" }/" indoor_flight.launch.yaml

cp freyja_flight.launch.yaml /home/ubuntu/ros2_drone_ws/src/Freyja/
cp mavros_config_freyja.yaml /home/ubuntu/ros2_drone_ws/src/Freyja/freyja_configfiles/launch/
cp indoor_flight.launch.yaml /home/ubuntu/ros2_drone_ws/
