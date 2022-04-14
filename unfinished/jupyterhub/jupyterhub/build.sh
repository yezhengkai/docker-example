#!/bin/bash
## setting
path="."
Dockerfile="${path}/Dockerfile"
image_name="kai/jupyterhub:1.4.2"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
