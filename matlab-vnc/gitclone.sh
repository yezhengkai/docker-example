#!/bin/bash
## docker vnc
# https://hub.docker.com/r/aicampbell/vnc-ubuntu18-xfce
# https://hub.docker.com/r/consol/ubuntu-xfce-vnc
# https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc
## bash and sed
# https://stackoverflow.com/questions/11703900/sed-comment-a-matching-line-and-x-lines-after-it
# https://unix.stackexchange.com/questions/439808/sed-comment-several-lines
# https://unix.stackexchange.com/questions/128593/simplest-way-to-comment-uncomment-certain-lines-using-command-line
# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
# https://github.com/docker-library/mongo/blob/master/4.2/docker-entrypoint.sh
# https://stackoverflow.com/questions/3869072/test-for-non-zero-length-string-in-bash-n-var-or-var


## pull
# docker pull aicampbell/vnc-ubuntu18-xfce:latest


## clone source code
# check git command
command -v git 2>&1 >/dev/null ||
{ echo "Git is not installed. Installing.." >&2;
  sudo apt-get install git
}
# git clone 
if [ -d "base-container-template" ]; then
    rm -rf base-container-template
    git clone https://github.com/Calipsoplus/base-container-template.git
else
    git clone https://github.com/Calipsoplus/base-container-template.git
fi


## modify "base-container-template/src/common/install/no_vnc.sh"
# 1. comment out line 10 
# 2. comment out last line
# 3. use websockify v0.8.0 
# 4. use index.html
sed -i '{10 s/^/\#/
$ s/^/\#/
10 a # update to v0.8.0
10 a wget -qO- https://github.com/novnc/websockify/archive/v0.8.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
$ a # use full html
$ a ln -s $NO_VNC_HOME/vnc.html $NO_VNC_HOME/index.html
}' base-container-template/src/common/install/no_vnc.sh


## modify "base-container-template/src/common/scripts/vnc_startup.sh"
# comment out line 63 "sudo usermod --password $(openssl passwd -1 default) default"
# comment out line 66 "sudo usermod -aG users default"
# comment out line 72 "sudo service xrdp start"
# replace line 96 "echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH"
sed -i '{63 s/^/#/
66 s/^/#/
72 s/^/#/
96 s/.*/\
if [ ${VNC_PW-} ] \&\& [ ${VNC_PW_FILE-} ] \&\& [ "${VNC_PW}" != "vncpassword" ]; then\
    echo >\&2 "error: both VNC_PW and VNC_PW_FILE are set (but are exclusive)"\
    exit 1\
fi\
\
if [ ${VNC_PW_FILE:+default} ]; then\
    cat ${VNC_PW_FILE} | vncpasswd -f >> $PASSWD_PATH\
else\
    echo "${VNC_PW}" | vncpasswd -f >> $PASSWD_PATH\
fi/
}' base-container-template/src/common/scripts/vnc_startup.sh


## modify "base-container-template/Dockerfile.ubuntu18.xfce.vnc"
# 1. use our image "cgrg/matlab-ssh:gpu"
# 2. install "htop": An interactive system-monitor process-viewer and process-manager. (CLI)\
# 3. install "gnome-system-monitor": gnome-system-monitor
# 4. install "file-roller": unzip file
# 5. install "p7zip*": support 7z format
# 6. install "gedit": gnome editor
# 7. install "okular": pdf viewer\
# 8. install "eog": image viewer (eye of gnome)
# 9. install "sudo"
# 10. comment out line 58 "RUN apt-get install -y sudo xrdp"
# 11. comment out line 61 "RUN chgrp 100 /etc/passwd"
# 12. comment out line 67 "EXPOSE 3389"
sed -i '{3 s/ubuntu:18.04/cgrg\/matlab-ssh:gpu/g
64 a RUN apt-get update \\ \
    && sudo apt-get upgrade -y \\ \
    && sudo apt-get install -y htop gnome-system-monitor file-roller p7zip* gedit okular eog sudo\\ \
    && sudo apt-get clean -y \\ \
    && rm -rf /var/lib/apt/lists/* \n
58 s/^/#/
61 s/^/#/
67 s/^/#/
}' base-container-template/Dockerfile.ubuntu18.xfce.vnc
