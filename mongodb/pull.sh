#!/bin/bash

tag="4.2.3-bionic"
image="mongo:${tag}"

docker pull ${image}