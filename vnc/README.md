- [Create an image that provides VNC services](#create-an-image-that-provides-vnc-services)
  - [1. Clone from github](#1-clone-from-github)
  - [2. Build image from dockerfile](#2-build-image-from-dockerfile)
- [Use image](#use-image)
  - [1. Run docker container](#1-run-docker-container)
  - [2. Use noVNC service](#2-use-novnc-service)

# Create an image that provides VNC services

## 1. Clone from github
Clone source code and modify some parts.
```bash
bash gitclone.sh
```

## 2. Build image from dockerfile
You can change variables in [build.sh](build.sh).
```bash
bash build.sh
```


# Use image
## 1. Run docker container
You can change variables in [run.sh](run.sh).

Note that if your Docker CE version is v18, you should change the corresponding part of the option "gpus".
```bash
bash run.sh
```

## 2. Use noVNC service
1. Open a web browser and type "<ip>: <port>" in the top search panel to use the container (note: Default port is 6901).
2. Enter noVNC's connection password (note: default password is 12345678).

> References:
> - https://hub.docker.com/r/aicampbell/vnc-ubuntu18-xfce
> - https://hub.docker.com/r/consol/ubuntu-xfce-vnc
> - https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc
