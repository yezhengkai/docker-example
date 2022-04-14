#!/bin/bash
# reference:
# https://www.arthurtoday.com/2016/07/how-to-setup-docker-container-timezone-host.html

## setting
# basic information
image_name="kai/vnc-ubuntu18-xfce"
container_name="vnc-ubuntu18-xfce"
hostname_in_container="kai_vnc"

# RDP port
host_port_rdp=3389
container_port_rdp=3389
port_rdp="${host_port_rdp}:${container_port_rdp}"
# the following two lines are tha same as above line
# port_ssh=`printf "%s:%s" "$host_port_ssh" "$container_port_ssh"`
# port_ssh="$host_port_ssh:$container_port_ssh"

# VNC port
host_port_vnc=5901
container_port_vnc=5901
port_vnc="${host_port_vnc}:${container_port_vnc}"

# noVNC port
host_port_novnc=6901
container_port_novnc=6901
port_novnc="${host_port_novnc}:${container_port_novnc}"

# mount volume in ssd
host_folder_ssd="/home/lab/volume"
container_folder_ssd="/volume"
folder_ssd="${host_folder_ssd}:${container_folder_ssd}"

# mount volume in hdd
host_folder_hdd="/data-hdd/shared"
container_folder_hdd="/data-hdd/shared"
folder_hdd="${host_folder_hdd}:${container_folder_hdd}"

# gpus
# 1. Start a GPU enabled container on all GPUs.
#    gpus="all"
# 2. Start a GPU enabled container on two GPUs.
#    gpus=2
# 3. Starting a GPU enabled container on specific GPUs
#    gpus="device=1,2"
#    gpus="device=GPU-3a23c669-1f69-c64e-cf85-44e9b07e7a2a"
# If there is an error passing the gpus option, you can try passing the gpu environment variable
#    NVIDIA_VISIBLE_DEVICES=3
#
# References:
# https://github.com/NVIDIA/nvidia-docker
# https://docs.docker.com/engine/reference/commandline/run/#access-an-nvidia-gpu
# https://devblogs.nvidia.com/gpu-containers-runtime/
gpus="all"

# VNC environment variable
VNC_RESOLUTION="1920x1080"
VNC_PW="12345678"

# make user in container the same as in host
uid=1001
gid=1001

# timezone
# method 1: mount volume "/etc/localtime"
# TZ="/etc/localtime:/etc/localtime:ro"
# method 2: set timezone environment variable
TZ="Asia/Taipei"

# other options
force_remove_container=true

## run container
# remove container
if [ "$force_remove_container" = true ]; then
    docker container rm -v -f ${container_name}
fi

# run container
docker run -d \
    -e "TZ=${TZ}" \
    -e "VNC_RESOLUTION=${VNC_RESOLUTION}" \
    -e "VNC_PW=${VNC_PW}" \
    -p ${port_rdp} \
    -p ${port_vnc} \
    -p ${port_novnc} \
    --user "${uid}:${gid}" \
    --group-add 100 \
    --shm-size=512m \
    --gpus ${gpus} \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name}
