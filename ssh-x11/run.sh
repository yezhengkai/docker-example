#!/bin/bash
## setting
# basic information
image_name="cgrg/ssh-x11:gpu"
container_name="ssh-x11-gpu"
hostname_in_container="cgrg_ssh_x11_gpu"

# SSH port
host_port_ssh=49154
container_port_ssh=22
port_ssh="${host_port_ssh}:${container_port_ssh}"

# mount volume in ssd
host_folder_ssd="/data-ssd/shared"
container_folder_ssd="/data-ssd/shared"
folder_ssd="${host_folder_ssd}:${container_folder_ssd}"

# mount volume in hdd
host_folder_hdd="/data-hdd/shared"
container_folder_hdd="/data-hdd/shared"
folder_hdd="${host_folder_hdd}:${container_folder_hdd}"

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
docker run -d --rm \
    -e "TZ=${TZ}" \
    -p ${port_ssh} \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name}