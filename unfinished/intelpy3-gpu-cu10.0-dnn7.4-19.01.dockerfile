# References:
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/gpu-jupyter.Dockerfile
# https://hub.docker.com/layers/tensorflow/tensorflow/2.0.0-gpu-py3-jupyter/images/sha256-613cdca993785f7c41c744942871fc5358bc0110f6f5cb5b00a4b459356d55e4
# https://github.com/honghulabs/DockerKeras/blob/master/Dockerfiles/IntelPython3/intelpy3-gpu-cu10.0-dnn7.4-19.01.dockerfile
# https://github.com/honghulabs/DockerKeras/blob/master/Dockerfiles/TensorFlow/tensorflow-cu10.0-dnn7.4-avx2-19.01.dockerfile
# https://github.com/jimmy60504/SeisNN/blob/master/docker/Dockerfile
# https://peihsinsu.gitbooks.io/docker-note-book/content/dockerfile-env-vs-arg.html

ARG UBUNTU_VERSION=18.04

####
# nvidia.partial.Dockerfile
ARG ARCH=
ARG CUDA=10.0
FROM nvidia/cuda${ARCH:+-$ARCH}:${CUDA}-base-ubuntu${UBUNTU_VERSION} as base
# ARCH and CUDA are specified again because the FROM directive resets ARGs
# Because an ARG instruction goes out of scope at the end of the build stage where it was defined.
# (but their default value is retained if set previously)
ARG ARCH
ARG CUDA
ARG CUDNN=7.6.2.24-1

# Needed for string substitution
SHELL ["/bin/bash", "-c"]
# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cuda-command-line-tools-${CUDA/./-} \
        cuda-cublas-${CUDA/./-} \
        cuda-cufft-${CUDA/./-} \
        cuda-curand-${CUDA/./-} \
        cuda-cusolver-${CUDA/./-} \
        cuda-cusparse-${CUDA/./-} \
        curl \
        libcudnn7=${CUDNN}+cuda${CUDA} \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        software-properties-common \
        unzip

RUN [ ${ARCH} = ppc64le ] || (apt-get update && \
        apt-get install -y --no-install-recommends libnvinfer5=5.1.5-1+cuda${CUDA} \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*)

# For CUDA profiling, TensorFlow requires CUPTI.
# ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Link the libcuda stub to the location where tensorflow is searching for it and reconfigure
# dynamic linker run-time bindings
# RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
#     && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
#     && ldconfig


####
# Install some useful packages.
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libcurl4-openssl-dev \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        openjdk-8-jdk \
        openjdk-8-jre-headless \
        wget \
        qt5-default \
        apt-utils \
        cmake \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libtiff-dev \
        libdc1394-22-dev \
        unixodbc \
        unixodbc-dev \
        graphviz \
        htop \
        vim && \
        apt clean && \
        rm -rf /var/lib/apt/lists/*


####
# Install "Intel® Distribution for Python".
WORKDIR /tmp
RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
    apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
    wget https://apt.repos.intel.com/setup/intelproducts.list -O /etc/apt/sources.list.d/intelproducts.list && \
    apt update && apt install -y --no-install-recommends intelpython3=${INTEL_PYTHON_VER}

# Set up env variables (Intel® Distribution for Python).
ENV PATH=/opt/intel/intelpython3/bin:${PATH} \
    LD_LIBRARY_PATH=/opt/intel/intelpython3/lib:${LD_LIBRARY_PATH} \
    C_INCLUDE_PATH=/opt/intel/intelpython3/include:${C_INCLUDE_PATH}


# Install/upgrade Python3 packages:
#   1. Install Dask (for efficient multi-core parallelism). More info: 
#       * https://software.intel.com/en-us/blogs/2016/04/04/unleash-parallel-performance-of-python-programs
#       * http://conference.scipy.org/proceedings/scipy2016/pdfs/anton_malakhov.pdf
#   2. Also, some useful packages are to be installed or upgraded (for image visualization/augmentation, etc).
RUN pip --no-cache-dir install "dask[complete]" \
                               seaborn \
                               bokeh \
                               autograd \
                               mlxtend \
                               watermark \
                               pydot-ng \
                               tqdm \
                               oauth2client \
                               pygsheets \
                               tables \
                               pydicom \
                               imageio \
                               bs4 \
                               statsmodels \
                               pyodbc \
                               SQLAlchemy \
                               gpustat && \
    pip --no-cache-dir install git+https://github.com/aleju/imgaug && \
    pip --no-cache-dir install --upgrade --upgrade-strategy only-if-needed h5py && \
    rm -rf /tmp/pip* && \
    rm -rf /root/.cache

# Install OpenCV
WORKDIR /opt/opencv
RUN git clone https://github.com/opencv/opencv.git /opt/opencv && \
    git checkout ${OPENCV_VER} && \
    mkdir build && \
    cd build && \
    cmake -DOPENCV_GENERATE_PKGCONFIG=ON \
          -DWITH_TBB=ON \
          -DBUILD_NEW_PYTHON_SUPPORT=ON \
          -DWITH_V4L=ON \
          -DINSTALL_C_EXAMPLES=OFF \
          -DINSTALL_PYTHON_EXAMPLES=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DWITH_QT=ON \
          -DWITH_OPENGL=ON \
          -DENABLE_FAST_MATH=1 \
          -DCUDA_FAST_MATH=0 \
          -DWITH_CUDA=0 .. && \
    make -j${NUM_CPUS_FOR_BUILD}  && \
    make install && \
    ldconfig

RUN pip --no-cache-dir install jupyter matplotlib jupyter_http_over_ws
RUN jupyter serverextension enable --py jupyter_http_over_ws

RUN apt-get autoremove -y

# Add the "ipyrun" command. It executes the given notebook & transform it into a HTML file.
RUN printf '#!/bin/bash\njupyter nbconvert --ExecutePreprocessor.timeout=None \
                                           --allow-errors \
                                           --to html \
                                           --execute $1' > /sbin/ipyrun && \
    chmod +x /sbin/ipyrun

# Shorten "nvidia-smi" as "smi" ; shorten "watch -n 1 nvidia-smi" as "wsmi".
RUN { printf 'alias smi="nvidia-smi"\nalias wsmi="watch -n 1 nvidia-smi"\n'; cat /etc/bash.bashrc; } >/etc/bash.bashrc.new && \
    mv /etc/bash.bashrc.new /etc/bash.bashrc

# Using UTF-8 for the environment.
ENV LANG=C.UTF-8

WORKDIR /tf
# Expose port 8888 for Jupyter.
EXPOSE 8888
RUN python3 -m ipykernel.kernelspec
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root"]