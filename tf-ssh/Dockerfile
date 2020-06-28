# The dockerfile is mainly referenced from
# https://github.com/jimmy60504/SeisNN/blob/master/docker/Dockerfile
#
# Other reference:
# https://github.com/tensorflow/tensorflow/tree/master/tensorflow/tools/dockerfiles
# https://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/
# https://docs.docker.com/engine/examples/running_ssh_service/#environment-variables
# https://jimmylin212.github.io/post/0007_create_an_ssh_login_image/?fbclid=IwAR2Mlc6UTSQBEZLDNwxBDKEWQihiNoboqNYVYRY3bRFL8J17msxSajuF_2s
# https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf
# https://stackoverflow.com/questions/44683119/dockerfile-replicate-the-host-user-uid-and-gid-to-the-image
# sudoer:
# https://superuser.com/questions/357467/what-do-the-alls-in-the-line-admin-all-all-all-in-ubuntus-etc-sudoers
# http://linux.vbird.org/linux_basic/0410accountmanager.php#visudo
# https://www.hostinger.com/tutorials/sudo-and-the-sudoers-file/

# base image
FROM tensorflow/tensorflow:2.1.0-gpu-py3-jupyter

# skip the setup of the keyboard-configuration package
# Unlike an ARG instruction, ENV values are always persisted in the built image.
ARG DEBIAN_FRONTEND=noninteractive

# replace apt mirror from default to NCHC
# RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

# mark a package as held back
RUN apt-mark hold libcudnn7

# update list, upgrade all package and install essential packages
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install sudo openssh-server xauth xorg openbox \
        vim htop screen reptyr git ffmpeg \
        libproj-dev proj-data proj-bin libgeos-dev \
    && rm -rf /var/lib/apt/lists/*

# all users in the staff group connected from any host have privileges to run any command
RUN echo '%staff   ALL=(ALL:ALL) ALL' >> /etc/sudoers

# upgrade pip and install essential packages
RUN pip3 install --upgrade pip \
    && pip3 uninstall -y enum34 \
    && python3 -m pip --no-cache-dir install --upgrade \
        tfx tensorflow-probability pyyaml obspy \
        scikit-learn sklearn tqdm Cartopy Pillow seaborn \
        numba pandas ruamel.yaml SimPEG psycopg2-binary \
    && rm -rf /tmp/pip* \
    && rm -rf /root/.cache

# create /var/run/sshd to make sshd run correctly
RUN mkdir /var/run/sshd
# 1. Open the root login function
# 2. Open X11 forwarding
# 3. Not using localhost
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Delete Tensorflow login message for sftp login
RUN mv /etc/bash.bashrc /etc/bash.bashrc.old
RUN touch /etc/bash.bashrc

ENV LD_LIBRARY_PATH /usr/local/cuda-10.1/extras/CUPTI/lib64:$LD_LIBRARY_PATH


# expose ssh port and run sshd
EXPOSE 22

COPY ./src/docker_entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/docker_entrypoint.sh \
    && mkdir /docker-entrypoint-init.d
ENTRYPOINT ["docker_entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D"]
