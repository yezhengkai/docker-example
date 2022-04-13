- [1. Define YAML](#1-define-yaml)
- [2. Define entrypoint](#2-define-entrypoint)
- [3. Define secrets](#3-define-secrets)
- [4. Run compose](#4-run-compose)
- [5. Resource managements](#5-resource-managements)
- [References](#references)


# 1. Define YAML
Change [docker-compose.yml](docker-compose.yml) to fit your situation.

# 2. Define entrypoint
Change scripts in [entrypoint](entrypoint) directory.

# 3. Define secrets
Change secret files in [secrets](secrets) directory.

# 4. Run compose
```bash
bash run_compose.sh
```
# 5. Resource managements
Display a live stream of container(s) resource usage statistics
```bash
docker stats [OPTIONS] [CONTAINER...]
```

Update configuration of one or more containers
```bash
docker container update [OPTIONS] CONTAINER [CONTAINER...]
```

# References
- [在 Docker Compose file 3 下限制 CPU 與 Memory](https://blog.yowko.com/docker-compose-3-cpu-memory-limit/)
- [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)