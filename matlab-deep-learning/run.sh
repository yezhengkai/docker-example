#!/bin/bash
# reference:
# https://www.arthurtoday.com/2016/07/how-to-setup-docker-container-timezone-host.html
# https://www.mathworks.com/help/cloudcenter/ug/matlab-deep-learning-container-on-dgx.html

## setting
# basic information
image_name="nvcr.io/partners/matlab:r2019b"
container_name="matlab"
hostname_in_container="kai_matlab"

# VNC port
host_port_vnc=5901
container_port_vnc=5901
port_vnc="${host_port_vnc}:${container_port_vnc}"
# the following two lines are tha same as above line
# port_ssh=`printf "%s:%s" "$host_port_ssh" "$container_port_ssh"`
# port_ssh="$host_port_ssh:$container_port_ssh"

# web browser port
host_port_web=6080
container_port_web=6080
port_web="${host_port_web}:${container_port_web}"

# mount volume in ssd
host_folder_ssd="/data-ssd/shared"
container_folder_ssd="/data-ssd/shared"
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

# vnc password
PASSWORD=12345678

# timezone
# method 1: mount volume "/etc/localtime"
# TZ="/etc/localtime:/etc/localtime:ro"
# method 2: set timezone environment variable
TZ="Asia/Taipei"

# other options
force_remove_container=true


## run container
# Remove tf container
if [ "$force_remove_container" = true ]; then
	docker container rm -v -f ${container_name}
fi

# Run tf container
docker run -d -it\
    -e "PASSWORD=${PASSWORD}" \
    -e "TZ=${TZ}" \
    -p ${port_vnc} \
    -p ${port_web} \
    --shm-size=512M \
    --gpus ${gpus} \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name}
