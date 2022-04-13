#!/bin/bash
## setting
path="."
Dockerfile="${path}/Dockerfile"
image_name="kai/tf-ssh"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}