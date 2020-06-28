## References:
# https://benit.github.io/blog/2019/02/15/ssh-x11-docker/
# https://gist.github.com/udkyo/c20935c7577c71d634f0090ef6fa8393
# https://xenby.com/b/220-%E6%95%99%E5%AD%B8-%E7%94%A2%E7%94%9Fssh-key%E4%B8%A6%E4%B8%94%E9%80%8F%E9%81%8Ekey%E9%80%B2%E8%A1%8C%E5%85%8D%E5%AF%86%E7%A2%BC%E7%99%BB%E5%85%A5
# https://askubuntu.com/questions/213678/how-to-install-x11-xorg


# base image
FROM ubuntu:18.04

# replace apt mirror from default to NCHC
# RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

# update list, upgrade all package, install essential packages and clean up the apt cache
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install openssh-server xauth xorg openbox \
    && rm -rf /var/lib/apt/lists/*

# Create /var/run/sshd makes sshd run correctly and creates /root/.ssh to store the public key
RUN mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh

# 1. Open the root login function
# 2. Open X11 forwarding
# 3. Not using localhost
# 4. Paste public key (NOTE: `RUN echo 'root:password' | chpasswd` does not work in ubuntu 18.04!!)
RUN sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11Forwarding.*$/X11Forwarding yes/" /etc/ssh/sshd_config \
    && sed -i "s/^.*X11UseLocalhost.*$/X11UseLocalhost no/" /etc/ssh/sshd_config \
    && grep "^X11UseLocalhost" /etc/ssh/sshd_config || echo "X11UseLocalhost no" >> /etc/ssh/sshd_config \
    && echo "YOUR_PUB_KEY_HERE" >> /root/.ssh/authorized_keys
    # && sed -i "s/^.*X11DisplayOffset.*$/X11DisplayOffset 10/" /etc/ssh/sshd_config \
    # && sed -i "s/^.*ForwardAgent.*$/ForwardAgent yes/" /etc/ssh/sshd_config \
    # && sed -i "s/^.* ForwardX11Trusted.*$/ForwardX11Trusted yes/" /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# expose ssh port and run sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
