#!/bin/bash
## setting
path="."
Dockerfile="${path}/Dockerfile"
image_name="kai/matlab-notebook:hub-1.4.2-r2020b"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
