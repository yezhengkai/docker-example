#!/bin/bash

#ymd=$1
#station=$2

## set hardcoded arguments
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

## setting
# basic information
image_name="kai/miniconda3:4.9.2"
container_name="kai-miniconda3"
hostname_in_container="kai_miniconda3"

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

# run container
docker run -it \
    -v ${TZ} \
    -v ${CWD}/docker-entrypoint-init.d:/docker-entrypoint-init.d \
    --rm \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name} \
    /bin/bash -c "runuser -l user -c $'
conda activate myenv
conda info
python -c \'print(\"We can run python!\")\'
'"
