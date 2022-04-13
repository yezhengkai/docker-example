#!/bin/bash

docker run -d \
  -p 5000:5000 \
  -e REGISTRY_STORAGE_DELETE_ENABLED=true \
  --restart=always \
  --name registry \
  -v /data-hdd/docker-local-registry:/var/lib/registry \
  registry:2
