# The dockerfile is mainly referenced from
# https://github.com/defeo/jupyterhub-docker/blob/master/jupyterhub/Dockerfile
#
# Other references:
# https://github.com/jupyterhub/jupyterhub/blob/main/Dockerfile

FROM jupyterhub/jupyterhub:1.4.2

# Copy the JupyterHub configuration in the container
#COPY jupyterhub_config.py .

# Install
RUN pip3 install --no-cache-dir --upgrade setuptools pip \
    && pip3 install --no-cache-dir \
        dockerspawner wrapspawner jupyterhub-nativeauthenticator

