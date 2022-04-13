#!/bin/bash
## setting
path="."
Dockerfile="${path}/Dockerfile"
image_name="kai/miniconda3:4.9.2"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
