#!/bin/bash
## References:
# https://stackoverflow.com/questions/11245144/replace-whole-line-containing-a-string-using-sed


## setting default variables
# base_image="cgrg/ssh-x11:gpu"

path="."
Dockerfile="${path}/Dockerfile"
image_name="kai/matlab-ssh:gpu"


# replace "FROM ..." whole line as "FROM ${base_image}""
# sed '/FROM/c FROM '"${A}"'' Dockerfile

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
