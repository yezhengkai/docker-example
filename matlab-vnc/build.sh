#!/bin/bash
## setting
path="./base-container-template"
Dockerfile="${path}/Dockerfile.ubuntu18.xfce.vnc"
image_name="cgrg/matlab-vnc:gpu"


## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
