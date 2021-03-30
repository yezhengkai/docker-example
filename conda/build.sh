#!/bin/bash
## setting
path="."
Dockerfile="${path}/Dockerfile"
image_name="cgrg/conda"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
