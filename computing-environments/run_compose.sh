#!/bin/bash
# References:
# https://devblog.axway.com/apis/create-api-builder-multi-container-application-using-docker-part-1/
# http://arder-note.blogspot.com/2018/05/docker-container-link-network.html

# copy tf_ssh initialization file
mkdir -p ./entrypoint/tf-entry/
cp ./entrypoint/tf-backup/* ./entrypoint/tf-entry/

# start service
docker-compose down
docker-compose --compatibility up -d
