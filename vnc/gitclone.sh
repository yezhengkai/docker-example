#!/bin/bash
## docker vnc
# https://hub.docker.com/r/aicampbell/vnc-ubuntu18-xfce
# https://hub.docker.com/r/consol/ubuntu-xfce-vnc
# https://hub.docker.com/r/dorowu/ubuntu-desktop-lxde-vnc
## bash techniques
# https://stackoverflow.com/questions/7292584/how-to-check-if-git-is-installed-from-bashrc
# https://charleslin74.pixnet.net/blog/post/405455902

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

# use new version of websockify and full html
sed -i '{10 s/^/\#/
$ s/^/\#/
10 a # update to v0.8.0
10 a wget -qO- https://github.com/novnc/websockify/archive/v0.8.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
$ a # use full html
$ a ln -s $NO_VNC_HOME/vnc.html $NO_VNC_HOME/index.html
}' base-container-template/src/common/install/no_vnc.sh