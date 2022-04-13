# docker-example
Repository of Dockerfile that I use and create

## Prerequisite
1. [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
2. [nvidia-docker](https://github.com/NVIDIA/nvidia-docker)
3. [docker-compose](https://docs.docker.com/compose/install/)

Some Docker images use GPUs, so nvidia-docker needs to be installed.

Please note that nvidia-docker currently only runs on Linux.

## Docker images
Based on the README files in each directory, create or pull the image and run the container you need.

<mark>Scripts in this directory and subdirectories are for Ubuntu.</mark>

---
## Common commands
1. Run a command in a new container
    ```bash
    docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
     ```

2. Remove container:
    ```bash
    docker container rm [OPTIONS] CONTAINER [CONTAINER...]
    ```
    or
    ```bash
    docker rm [OPTIONS] CONTAINER [CONTAINER...]
    ```

3. Remove image:
    ```bash
    docker image rm [OPTIONS] IMAGE [IMAGE...]
    ```
    or
    ```bash
    docker rmi [OPTIONS] IMAGE [IMAGE...]