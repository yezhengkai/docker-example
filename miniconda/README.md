- [Create an image that provides miniconda](#create-an-image-that-provides-miniconda)
  - [Customize your Dockerfile](#customize-your-dockerfile)
  - [Customize your conda environment.yml](#customize-your-conda-environmentyml)
  - [Build image](#build-image)
- [Use image](#use-image)
  - [Customize your entrypoint](#customize-your-entrypoint)
  - [Run docker container](#run-docker-container)


# Create an image that provides miniconda
## Customize your Dockerfile 
You can choose a different version of the miniconda image and you can add/remove packages in the apt-get section.

## Customize your conda environment
You can customize [environment.yml](./src/conda-env/environment.yml).

## Build image
You can change variables in [build.sh](build.sh).
```bash
bash build.sh
```


# Use image
## Customize your entrypoint 
Following the hints in the [docker_useradd.sh](./docker-entrypoint-init.d/docker_useradd.sh), you can create multiple users with different privileges in the container.

In addition, you can create your own *.sh and put it in the `docker-entrypoint-init.d` directory.

## Run docker container
You can change variables in [run.sh](run.sh).
```bash
bash run.sh
```

