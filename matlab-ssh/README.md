- [Create an image based on the ssh-x11 image that provides Matlab services](#create-an-image-based-on-the-ssh-x11-image-that-provides-matlab-services)
  - [1. Prepare matlab installation file](#1-prepare-matlab-installation-file)
  - [2. Prepare base image](#2-prepare-base-image)
  - [3. Change base image (optional)](#3-change-base-image-optional)
  - [4. Build temp image from dockerfile](#4-build-temp-image-from-dockerfile)
  - [5. Run temp image](#5-run-temp-image)
  - [6. SSH into container](#6-ssh-into-container)
  - [7. Install matlab in container](#7-install-matlab-in-container)
  - [8. Commit as a new image that already contains Matlab](#8-commit-as-a-new-image-that-already-contains-matlab)
- [Use image](#use-image)
  - [1. Run docker container](#1-run-docker-container)
  - [2. SSH into container](#2-ssh-into-container)
- [TODO](#todo)

<li>
<mark>
Alternatively, you can create a matlab image by following the guidelines in the <a href="https://github.com/mathworks-ref-arch/matlab-dockerfile" rel="nofollow">matlab-dockerfile</a> website.
</mark>
</li>
<li>
<mark>
The image is not currently installed with CUDA.
</mark>
</li>

# Create an image based on the ssh-x11 image that provides Matlab services

## 1. Prepare matlab installation file
Download the required version of matlab installation files from the [official website](https://www.mathworks.com/products/matlab.html). Then, Unzip file to src folder.

## 2. Prepare base image
Please refer to ssh-x11 directory to create base image.

## 3. Change base image (optional)
You can choose "kai/ssh-x11:cpu" or "kai/ssh-x11:gpu" as base images.

## 4. Build temp image from dockerfile
You can change variables in [build.sh](build.sh).
```bash
bash build.sh
```

## 5. Run temp image
You can change variables in [run.sh](run.sh).
```bash
bash run.sh
```

## 6. SSH into container
Default port is 49154.
```bash
ssh -X root@<ip>/<hostname> -p <port>
```

## 7. Install matlab in container
1. In the container, we can install the matlab by this command. 
```bash
/matlab/matlab_Rxxxxx_glnxa64/install
```
2. In the installation step, "Create symbolic link to Matlab script in it" (use default location) should be checked.
3. Do not activate matlab at the end of the installation.
4. Clean up matlab installation files and tmp file.
```bash
rm -rf /tmp/*
```
5. Exit container.

## 8. Commit as a new image that already contains Matlab
```bash
docker commit matlab-ssh-gpu kai/matlab-ssh:gpu
```

If you successfully commit to a new image, you can delete the temporary container.

# Use image 
## 1. Run docker container
You can change variables in [run.sh](run.sh).
```bash
bash run.sh
```

## 2. SSH into container
Default port is 49154.
```bash
ssh -X root@<ip>/<hostname> -p <port>
```


---
# TODO
- [ ] improve the setting of matlab environment in Dockerfile
- [ ] support bash arguments parsing to facilitate the use of scripts