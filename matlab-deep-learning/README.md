
# Pull image from Nvidia GPU Cloud
Pull image.
``` bash
bash pull.sh
```

If you have not logged in to NVIDIA Container Registry before, you should enter the following text.
``` text
Username: $oauthtoken
Password: [Your NGC API key]
```

# Use image
## 1. Run docker container
You can change variables in [run.sh](run.sh).

Note that if your Docker CE version is v18, you should change the corresponding part of the option "gpus".
```bash
bash run.sh
```

## 2. Use noVNC service
1. Open a web browser and type "\<ip>:\<port>" in the top search panel to use the container (note: Default port is 6080).
2. Enter noVNC's connection password (note: default password is 12345678).