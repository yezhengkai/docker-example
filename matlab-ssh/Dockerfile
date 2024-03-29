## References
# https://github.com/mathworks-ref-arch/matlab-dockerfile/blob/master/Dockerfile


# base image
FROM kai/ssh-x11:gpu

# skip the setup of the keyboard-configuration package
ARG DEBIAN_FRONTEND=noninteractive

#### Get Dependencies ####
RUN apt-get update && apt-get install -y \
    ca-certificates \
    lsb-release \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcap2 \
    libcomerr2 \
    libcups2 \
    libdbus-1-3 \
    libfontconfig1 \
    libgconf-2-4 \
    libgcrypt20 \
    libgdk-pixbuf2.0-0 \
    libgssapi-krb5-2 \
    libgstreamer-plugins-base1.0-0 \
    libgstreamer1.0-0 \
    libgtk2.0-0 \
    libk5crypto3 \
    libkrb5-3 \
    libnspr4 \
    libnspr4-dbg \
    libnss3 \
    libpam0g \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libpangoft2-1.0-0 \
    libselinux1 \
    libsm6 \
    libsndfile1 \
    libudev1 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxft2 \
    libxi6 \
    libxmu6 \
    libxrandr2 \
    libxrender1 \
    libxslt1.1 \
    libxss1 \
    libxt6 \
    libxtst6 \
    libxxf86vm1 \
    procps \
    xkb-data \
    xvfb \
    x11vnc \
    xvfb \
    sudo \
    zlib1g


# Uncomment the following RUN apt-get statement to install extended locale support for MATLAB
RUN apt-get install -y locales locales-all

# Uncomment the following RUN ln -s statement if you will be running the MATLAB 
# license manager INSIDE the container.
# RUN ln -s ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3

# Uncomment the following RUN apt-get statement if you will be using Simulink 
# code generation capabilities, or if you will be using mex with gcc, g++, 
# or gfortran.
#
RUN apt-get install -y gcc g++ gfortran

# Uncomment the following RUN apt-get statement to enable running a program
# that makes use of MATLAB's Engine API for C and Fortran
# https://www.mathworks.com/help/matlab/matlab_external/introducing-matlab-engine.html
#
#RUN apt-get install -y csh

# Uncomment ALL of the following RUN apt-get statement to enable the playing of media files
# (mp3, mp4, etc.) from within MATLAB.
#
#RUN apt-get install -y libgstreamer1.0-0 \
# gstreamer1.0-tools \
# gstreamer1.0-libav \
# gstreamer1.0-plugins-base \
# gstreamer1.0-plugins-good \
# gstreamer1.0-plugins-bad \
# gstreamer1.0-plugins-ugly \
# gstreamer1.0-doc

# Uncomment the following RUN apt-get statement if you will be using the 32-bit tcc compiler
# used in the Polyspace product line.
#
#RUN apt-get install -y libc6-i386

# Finally clean up after apt-get
RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*  

CMD ["/usr/sbin/sshd", "-D"]
