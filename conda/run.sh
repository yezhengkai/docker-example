#!/bin/bash

## set hardcoded arguments
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

## setting
# basic information
image_name="cgrg/conda"
container_name="conda"
hostname_in_container="cgrg_conda"

# mount volume in database
host_folder_data="/home/user/database"
container_folder_data="/home/user/database"
folder_data="${host_folder_data}:${container_folder_data}"

# mount volume in workspace
host_folder_work="/home/user/workspace"
container_folder_work="/home/user/workspace"
folder_work="${host_folder_work}:${container_folder_work}"

# mount volume in python package
host_folder_package="/home/user/python_packages"
container_folder_package="/home/user/.local/lib/python3.8/site-packages"
folder_package="${host_folder_package}:${container_folder_package}"

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
  docker container rm -v -f ${container_name} > /dev/null 2>&1
fi

# run
docker run -it \
    -v ${TZ} \
    -v ${CWD}/docker-entrypoint-init.d:/docker-entrypoint-init.d \
    -v ${folder_data} \
    -v ${folder_work} \
    -v ${folder_package} \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name} \
    /bin/bash -c "echo done"
