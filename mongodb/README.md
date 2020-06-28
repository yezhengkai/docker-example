# Pull image from docker hub
Please check [mongodb's website](https://hub.docker.com/_/mongo) on docker hub to select the appropriate tag, then change the tag variable in [run.sh](run.sh).

Pull image.
``` bash
bash pull.sh
```

# Use image
## 1. Basic usage
You can change variables in [run.sh](run.sh) and [db_useradd.sh](entrypoint/db_useradd.sh).
```bash
bash run.sh
```

## 2. Basic setting of MongoDB container
Please refer to [mongodb's website](https://hub.docker.com/_/mongo) on docker hub for more details.

And here are some useful websites:
1. [How to enable authentication on MongoDB through Docker?](https://stackoverflow.com/questions/34559557/how-to-enable-authentication-on-mongodb-through-docker)
2. [基于 Docker 中的 MongoDB Auth 使用
](https://www.jianshu.com/p/03bbfb8307df)

## 3. Create a micro-service
If you want to create a microservice that uses other containers to connect to mongodb, you can refer to following websites.
1. [Docker container 互相連接 (link, network)](http://arder-note.blogspot.com/2018/05/docker-container-link-network.html)
2. [Create an API Builder Multi-Container Application Using Docker – Part 1](https://devblog.axway.com/apis/create-api-builder-multi-container-application-using-docker-part-1/)
3. [透過 Docker Compose 設定 network](https://titangene.github.io/article/networking-in-docker-compose.html)
4. [How To Set Up Flask with MongoDB and Docker](https://www.digitalocean.com/community/tutorials/how-to-set-up-flask-with-mongodb-and-docker)


---
> References:
> - [Docker container 互相連接 (link, network)](http://arder-note.blogspot.com/2018/05/docker-container-link-network.html)
> - [Create an API Builder Multi-Container Application Using Docker – Part 1](https://devblog.axway.com/apis/create-api-builder-multi-container-application-using-docker-part-1/)
> - [透過 Docker Compose 設定 network](https://titangene.github.io/article/networking-in-docker-compose.html)
> - [How To Set Up Flask with MongoDB and Docker](https://www.digitalocean.com/community/tutorials/how-to-set-up-flask-with-mongodb-and-docker)
> - [Docker run->network settings](https://docs.docker.com/engine/reference/run/#network-settings)
> - [Legacy container links](https://docs.docker.com/network/links/)
> - [Use bridge networks](https://docs.docker.com/network/bridge/##differences-between-user-defined-bridges-and-the-default-bridge)
> - [How to enable authentication on MongoDB through Docker?](https://stackoverflow.com/questions/34559557/how-to-enable-authentication-on-mongodb-through-docker)