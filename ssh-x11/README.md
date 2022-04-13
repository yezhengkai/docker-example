- [Create an image that provides SSH and X11 services](#create-an-image-that-provides-ssh-and-x11-services)
  - [1. Modify Dockerfile](#1-modify-dockerfile)
    - [1. Generate ssh key](#1-generate-ssh-key)
    - [2. Copy public key](#2-copy-public-key)
    - [3. Replace the YOUR_PUB_KEY_HERE](#3-replace-the-yourpubkeyhere)
  - [2. Build image from dockerfile](#2-build-image-from-dockerfile)
- [Use image](#use-image)
  - [1. Run docker container](#1-run-docker-container)
  - [2. SSH into container](#2-ssh-into-container)
- [TODO:](#todo)


# Create an image that provides SSH and X11 services
## 1. Modify Dockerfile
### 1. Generate ssh key
Follow the ssh-keygen prompts on the computer where you want to ssh into the container. If you are unfamiliar with ssh-keygen, you can just press enter.  
Following is an example.
```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/username/.ssh/id_rsa): <ENTER>
Enter passphrase (empty for no passphrase): <ENTER>
Enter same passphrase again: <ENTER>
Your identification has been saved in /home/username/.ssh/id_rsa.
Your public key has been saved in /home/username/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:R7Z/3NBsbmooUguPn3Q3uHDPgzFjxi20FmTX/TJULtI username@hostname
The key's randomart image is:
+---[RSA 2048]----+
|               oo|
|            o.o.o|
|          oo.oE o|
|         o .o.o+.|
|        S oo +.o+|
|        ....@o.= |
|         =o==B= +|
|        o.+=o*o+ |
|         oo...+. |
+----[SHA256]-----+
```

### 2. Copy public key
Display the public key with the following command. If you change the storage path, you should modify "~/.ssh/id_rsa.pub" in the following command.
```bash
cat ~/.ssh/id_rsa.pub 
```
Copy it for later use~

### 3. Replace the YOUR_PUB_KEY_HERE
Replace the YOUR_PUB_KEY_HERE string in the [./cpu/Dockerfile](./cpu/Dockerfile) or [./gpu/Dockerfile](./cpu/Dockerfile) with the public key.
Following is an example.
```dockerfile
RUN echo "ssh-rsa AAAAB3N5aC1yc2EAAAADAQABAAABAQCm1alLL4jkTazolSfYl3+bzlLVXAFKdvPPWFezgOo931kcyBvAczBFAyH+ZSpBSuN1OG2E4wLdRNSApep/y5QjJpqz4b/4wbI8MMqY3zV/b7/fZ2shpGaNNN8fY5qrpiADWRKB9ZppjE+Hninfo7VjAhgnZgNY7BIqVugaJl034n6P68bZfBMAdwqgH8xYWJRkXlTPWv+f/zqcRhDS0VdSp+ksPqmW3l5b90gBskLEhYMOoKnWVaYWufQMOAiqLgDB5jyq7eu5pqyNUxT6wIoJxQxui8aWvJp106SrWmAUngS6UmWfWrquE9swueXhbAQWXbreIx+PlEaoyMaOWmZx username@hostname" >> /root/.ssh/authorized_keys
```

## 2. Build image from dockerfile
You can change variables in [build.sh](build.sh).
```bash
# build ./gpu/Dockerfile to kai/ssh-x11:gpu image, which will provide CUDA.
bash build.sh -g|--gpu
# build ./cpu/Dockerfile to kai/ssh-x11:cpu image
bash build.sh -c|--cpu
# assign image name and optionally a tag in the 'name:tag' format
bash build.sh -c|-g|--cpu|--gpu -t|--tag name:tag

# For example: build ./gpu/Dockerfile to kai/newbie:v0 image
bash build.sh -g -t kai/newbie:v0
```

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
# TODO:
- [ ] automatically replace public key in Dockerfile.
- [ ] improve [./gpu/Dockerfile](./gpu/Dockerfile)

---
> References
> - [如何用 SSH 連進遠端主機內的 docker container?](https://jimmylab.wordpress.com/2018/12/05/ssh-docker-container/)
> - [Best practices for writing Dockerfiles](https://docs.docker.com/v17.09/engine/userguide/eng-image/dockerfile_best-practices/)
> - [Basic container for X11 forwarding goodness](https://gist.github.com/udkyo/c20935c7577c71d634f0090ef6fa8393)
> - [SSH X11 & docker](https://benit.github.io/blog/2019/02/15/ssh-x11-docker/)
> - [How to install X11/xorg?
](https://askubuntu.com/questions/213678/how-to-install-x11-xorg)
> - [[教學] 產生SSH Key並且透過KEY進行免密碼登入](https://xenby.com/b/220-%E6%95%99%E5%AD%B8-%E7%94%A2%E7%94%9Fssh-key%E4%B8%A6%E4%B8%94%E9%80%8F%E9%81%8Ekey%E9%80%B2%E8%A1%8C%E5%85%8D%E5%AF%86%E7%A2%BC%E7%99%BB%E5%85%A5)
> - [GitLab -- cuda/dist/ubuntu18.04/10.1](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/ubuntu18.04/10.1)
> - [GitHub -- tensorflow/tensorflow/tools/dockerfiles/dockerfiles/gpu-jupyter.Dockerfile](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/gpu-jupyter.Dockerfile)
> - [GitHub -- DockerKeras/Dockerfiles/IntelPython3/intelpy3-gpu-cu10.0-dnn7.4-19.01.dockerfile](https://github.com/honghulabs/DockerKeras/blob/master/Dockerfiles/IntelPython3/intelpy3-gpu-cu10.0-dnn7.4-19.01.dockerfile)