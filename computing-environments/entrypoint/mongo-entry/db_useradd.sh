#!/usr/bin/env bash
# References:
# https://docs.mongodb.com/manual/tutorial/enable-authentication/
# https://www.jianshu.com/p/03bbfb8307df
# https://eric0806.blogspot.com/2017/02/mongodb.html
# https://www.frodehus.dev/running-mongodb-in-docker-with-authentication/
# https://medium.com/@MaxouMask/secured-mongodb-container-6b602ef67885
# https://blackie1019.github.io/2017/04/11/Using-Mongo-Shell-to-Operating-MongoDB-Instance-on-Docker/


echo "Creating mongo users..."

mongo --port 27017 --authenticationDatabase "admin" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" << EOF
use cgrgdb
db.createUser(
  {
    user: "user1",
    pwd: "user1Pass",
    roles:[ {role: "readWrite",
             db: "cgrgdb"} ]
  }
)
db.createUser(
  {
    user: "user2",
    pwd: "user2Pass",
    roles:[ {role: "readWrite",
             db: "cgrgdb"} ]
  }
)
EOF

echo "Mongo users created."
