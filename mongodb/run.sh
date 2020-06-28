#!/bin/bash

## setting
# basic information
container_name="cgrg-mongodb"
image_name="mongo:4.2.3-bionic"
hostname_in_container="cgrg_mongodb"

# mongodb port
host_port_mongo=27017
container_port_mongo=27017
port_mongo="${host_port_mongo}:${container_port_mongo}"

# mongodb environment varibles
MONGO_INITDB_ROOT_USERNAME=root
MONGO_INITDB_ROOT_PASSWORD=rootPassHERE

# mount volume in hdd
host_folder_hdd="/data-hdd/mongodb"
folder_hdd="${host_folder_hdd}:/data/db"

# timezone
# method 1: mount volume "/etc/localtime"
# TZ="/etc/localtime:/etc/localtime:ro"
# method 2: set timezone environment variable
TZ="Asia/Taipei"

# other options
force_remove_container=true

## run container
# remove tf container
if [ "$force_remove_container" = true ]; then
    docker container rm -v -f ${container_name}
fi

docker run -d \
    -e "TZ=${TZ}" \
    -e "MONGO_INITDB_ROOT_USERNAME=${MONGO_INITDB_ROOT_USERNAME}" \
    -e "MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD}" \
    -p ${port_mongo} \
    -v "$PWD/entrypoint:/docker-entrypoint-initdb.d" \
    -v ${folder_hdd} \ 
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name}