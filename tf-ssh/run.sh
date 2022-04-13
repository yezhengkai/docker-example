#!/bin/bash
## References:
# https://www.arthurtoday.com/2016/07/how-to-setup-docker-container-timezone-host.html
# https://stackoverflow.com/questions/51309825/how-can-i-list-every-file-with-a-specific-extension-except-one-with-bash

## setting
# basic information
image_name="kai/tf-ssh"
container_name="tf-ssh"
hostname_in_container="kai_tf"

# ssh port
host_port_ssh=49154
container_port_ssh=22
port_ssh="${host_port_ssh}:${container_port_ssh}"
# the following two lines are tha same as above line
# port_ssh=`printf "%s:%s" "$host_port_ssh" "$container_port_ssh"`
# port_ssh="$host_port_ssh:$container_port_ssh"

# tensorboard port
# for multiple users you can assign a range of ports.
host_port_tb=6006
container_port_tb=6006
port_tb="${host_port_tb}:${container_port_tb}"

# jupyter notebook port
# for multiple users, you can assign a range of ports.
host_port_notebook=8888-8892
container_port_notebook=8888-8892
port_notebook="${host_port_notebook}:${container_port_notebook}"

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

# timezone
# method 1: mount volume "/etc/localtime"
TZ="/etc/localtime:/etc/localtime:ro"
# method 2: set timezone environment variable
# TZ="Asia/Taipei"

# other options
force_remove_container=true


## run container
# remove container
if [ "$force_remove_container" = true ]; then
    docker container rm -v -f ${container_name}
fi

# find all .sh except docker_entrypoint.sh in ./src/ and copy them to docker-entrypoint-init.d/
mkdir -p docker-entrypoint-init.d
cp `find ./src -maxdepth 1 -name '*.sh' ! -name 'docker_entrypoint.sh'` docker-entrypoint-init.d/

# run container
docker run -d \
    -p ${port_ssh} \
    -p ${port_tb} \
    -p ${port_notebook} \
    -v ${TZ} \
    -v ${PWD}/docker-entrypoint-init.d:/docker-entrypoint-init.d \
    --gpus ${gpus} \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name}
