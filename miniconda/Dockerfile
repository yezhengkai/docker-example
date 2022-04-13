# References:
# https://github.com/ContinuumIO/docker-images/issues/151
# https://towardsdatascience.com/conda-pip-and-docker-ftw-d64fe638dc45

# base image
FROM continuumio/miniconda3:4.9.2

SHELL [ "/bin/bash", "--login", "-c" ]

# create a conda environment
COPY ./src/conda-env/ /conda-env/
RUN cd /conda-env/; conda env update --prune --file environment.yml

# update list, upgrade all package and install essential packages
RUN apt-get --allow-releaseinfo-change update \
    && apt-get -y upgrade \
    && apt-get -y install sudo \
    && rm -rf /var/lib/apt/lists/*

# make non-activate conda commands available
RUN echo "export PATH=/opt/conda/bin:$PATH" >> /etc/profile; \
    # make conda activate command available from /bin/bash --login shells
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/profile; \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/skel/.profile; \
    # make conda activate command available from /bin/bash --interactive shells    
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/bash.bashrc; \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/skel/.bashrc

# copy entrypoint script
COPY ./src/entrypoint/docker_entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/docker_entrypoint.sh \
    && mkdir /docker-entrypoint-init.d
ENTRYPOINT ["docker_entrypoint.sh"]

CMD ["/bin/bash"]

