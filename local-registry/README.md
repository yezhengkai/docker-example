# Run local registry
```bash
./run_local_registry.sh
```

# Delete images on local registry
Delete a tag in a local registry without removing other tags pointing to the
same manifest.
```bash
regctl tag delete localhost:5000/<REPOSITORY>:<TAG>
```

Use registry's garbage collection to cleanup untagged manifests and unused blobs.
```bash
docker exec registry /bin/registry garbage-collect --delete-untagged /etc/docker/registry/config.yml
```

# References
- [Deploy a registry server](https://docs.docker.com/registry/deploying/)
- [Instatlling Docker and configuring a Docker registry](https://www.ibm.com/docs/en/fci/1.0.2?topic=installation-installing-docker-configuring-docker-registry)
- [GitHub: regclient/regclient](https://github.com/regclient/regclient)
- [Docker registry 刪除特定 Tag](https://www.gss.com.tw/blog/docker-registry-tag)
- [SO: Docker Registry v2 Images cannot be removed](https://stackoverflow.com/questions/42328301/docker-registry-v2-images-cannot-be-removed)
