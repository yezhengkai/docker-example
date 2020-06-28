#!/bin/bash
# References:
# https://devblog.axway.com/apis/create-api-builder-multi-container-application-using-docker-part-1/
# http://arder-note.blogspot.com/2018/05/docker-container-link-network.html

# copy tf_ssh initialization file 
cp ./entrypoint/tf_backup/* ./entrypoint/tf_entry/
# start service
docker-compose down
docker-compose up -d
