#!/bin/bash
# log in to the NVIDIA Container Registry
docker login nvcr.io
#Username: $oauthtoken
#Password: [NGC API key]

docker pull nvcr.io/partners/matlab:r2019b
