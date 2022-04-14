#!/bin/bash
## References:
# https://stackoverflow.com/questions/11245144/replace-whole-line-containing-a-string-using-sed

# setting
path="."
Dockerfile="${path}/Dockerfile"
image_name="kai/matlab-ssh:gpu"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
