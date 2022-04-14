🚧WIP
# Basic components of docker-compose

## JupyterHub
Authenticate and spawn jupyterlab for each user.
### [Native Authenticator](https://native-authenticator.readthedocs.io/en/latest/quickstart.html)
- `/hub/authorize` for admin to authorize users
- `/hub/change-password` for logged users to change password


## JupyterLab
The core computing environment.
### Docker image for each user
You can change the `jupyterlab/Dockerfile` to customize the image of each logged-in jupyterhub user.
We follow the [plutohub-juliacon2021](https://github.com/barche/plutohub-juliacon2021).
### Useful jupyter plugin
- jupytext


## Reverse proxy: Nginx
Reverse proxy for jupyterhub.

### Creating a self-signed SSL certification
Create `ssl.key` and `ssl.csr` by the following command:
```bash
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ssl.key -out ssl.csr
```

> ℹ️ Because the certification is self-signed, the web browser will definitely show a warning.


## File Browser
We use unofficial docker images support from [hurlenko/filebrowser-docker](https://github.com/hurlenko/filebrowser-docker). You can also check out the official [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser).


# References
- [❗GitHub: plutohub-juliacon2021❗](https://github.com/barche/plutohub-juliacon2021)
- [❗GitHub: terasakisatoshi/MyWorkflow.jl❗](https://github.com/terasakisatoshi/MyWorkflow.jl)
- [How to use Docker to Deploy Jupyter with Nginx](https://www.novixys.com/blog/use-docker-deploy-jupyter-nginx/)
- [DEPLOYING A CONTAINERIZED JUPYTERHUB SERVER WITH DOCKER](https://opendreamkit.org/2018/10/17/jupyterhub-docker/)
- [DOCKER – HOW TO SETUP JUPYTER BEHIND NGINX PROXY](https://hands-on.cloud/docker-how-to-setup-jupyter-behind-nginx-proxy/)
- [Creating a JupyterLab DockerSpawner image (launched by JupyterHub) that employs Fedora systemd(5)](https://discourse.jupyter.org/t/creating-a-jupyterlab-dockerspawner-image-launched-by-jupyterhub-that-employs-fedora-systemd-5/7179/3)
- [SO: Docker-compose jupyterhub issue](https://stackoverflow.com/questions/60948197/docker-compose-jupyterhub-issue)
- [GitHub: jupyterhub/jupyterhub/examples/bootstrap-script (Bootstrapping your users)](https://github.com/jupyterhub/jupyterhub/tree/main/examples/bootstrap-script)
- [❗Dockerspawner and volumes from host❗](https://discourse.jupyter.org/t/dockerspawner-and-volumes-from-host/7008/3)
- [❗How to configure the NB_UID using DockerSpawner with jupyterhub-singleuser image❗](https://groups.google.com/g/jupyter/c/-VJXHy5hnfM)
- [❗Jupyter Docker Stacks❗](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html)
- [GitHub: MATLAB Integration for Jupyter](https://github.com/mathworks-ref-arch/matlab-integration-for-jupyter)
- [jupyterhub: Using a reverse proxy](https://jupyterhub.readthedocs.io/en/stable/reference/config-proxy.html)
- [GitHub: MarvAmBass/docker-nginx-ssl-secure](https://github.com/MarvAmBass/docker-nginx-ssl-secure)
- [❗Flask 實作 Dockerfile + nginx + ssl 教學 (附GitHub完整程式)❗](https://www.maxlist.xyz/2020/01/19/docker-nginx/)
- [NGINX 設定 HTTPS 網頁加密連線，建立自行簽署的 SSL 憑證](https://blog.gtwang.org/linux/nginx-create-and-install-ssl-certificate-on-ubuntu-linux/)
- [webinstall.dev/jq](https://webinstall.dev/jq/)
