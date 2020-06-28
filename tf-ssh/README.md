- [Create an image that provides SSH and tf services](#create-an-image-that-provides-ssh-and-tf-services)
  - [1. Customize your Dockerfile](#1-customize-your-dockerfile)
  - [2. Build image](#2-build-image)
- [Use image](#use-image)
  - [1. Customize your entrypoint](#1-customize-your-entrypoint)
  - [2. Run docker container](#2-run-docker-container)
  - [3. SSH into container](#3-ssh-into-container)
  - [4. User jupyter notebook](#4-user-jupyter-notebook)

# Create an image that provides SSH and tf services
## 1. Customize your Dockerfile 
You can add or remove packages in the apt-get or pip3 section.

## 2. Build image
You can change variables in [build.sh](build.sh).
```bash
bash build.sh
```


# Use image
## 1. Customize your entrypoint 
Following the hints in the [docker_useradd.sh](./src/docker_useradd.sh), you can create multiple users with different privileges in the container.

In addition, you can create your own *.sh and put it in the ./src directory.

## 2. Run docker container
You can change variables in [run.sh](run.sh).

Note that if your Docker CE version is v18, you should change the corresponding part of the option "gpus".
```bash
bash run.sh
```

## 3. SSH into container
Default port is 49154.
```bash
ssh <username>@<ip>/<hostname> -p <port>
```

## 4. User jupyter notebook
```bash
jupyter notebook --ip 0.0.0.0 --port ${PORT} --no-browser --allow-root
```

> References:
> - [docker启动jupyter报错：OSError: [Errno 99] Cannot assign requested address](https://blog.csdn.net/qq_36396104/article/details/88805227)
> - [Change IPython/Jupyter notebook working directory](https://stackoverflow.com/questions/15680463/change-ipython-jupyter-notebook-working-directory)