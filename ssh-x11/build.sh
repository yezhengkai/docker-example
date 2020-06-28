#!/bin/bash
## References:
# https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# https://stackoverflow.com/questions/16905183/dash-double-semicolon-syntax
# https://pretzelhands.com/posts/command-line-flags


## Setting up default values.
path="./gpu"
image_name="cgrg/ssh-x11:gpu"
stop_assign=false

## parse arguments
flag=$(( ${flag} ))  # integer

while [[ $# -gt 0 ]]
do
    option="$1"

    case $option in
        -c|--cpu)
            path="./cpu"
            if [ "$stop_assign" != true ]; then
                image_name="cgrg/ssh-x11:cpu"
            fi
            shift # past argument
            flag=$(( ${flag} + 1 ))
            ;;
        -g|--gpu)
            path="./gpu"
            if [ "$stop_assign" != true ]; then
                image_name="cgrg/ssh-x11:gpu"
            fi
            shift # past argument
            flag=$(( ${flag} + 1 ))
            ;;
        -t|--tag)
            image_name="$2"
            shift # past argument
            shift # past value
            stop_assign=true
            ;;
        *)    # unknown option
            printf "Error! Unknown option ${option}
  Legal options are (-c|--cpu), (-g|--gpu), (-t|--tag)\n" >&2
            exit 1
            shift # past argument
            ;;
    esac
done

if [ ${flag} -gt 1 ]; then
    echo "Error! (-c|--cpu) and (-g|--gpu) cannot be used simultaneously" >&2
    exit 1
fi

Dockerfile="${path}/Dockerfile"

## build
docker image build -t ${image_name} -f ${Dockerfile} ${path}
