#!/bin/bash

## setting
path="./base-container-template"
Dockerfile="${path}/Dockerfile.ubuntu18.xfce.vnc"
image_name="cgrg/vnc-ubuntu18-xfce"


## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
