#!/usr/bin/env bash
# References:
# https://www.jianshu.com/p/03bbfb8307df
# https://eric0806.blogspot.com/2017/02/mongodb.html
# https://www.frodehus.dev/running-mongodb-in-docker-with-authentication/
# https://medium.com/@MaxouMask/secured-mongodb-container-6b602ef67885
# https://blackie1019.github.io/2017/04/11/Using-Mongo-Shell-to-Operating-MongoDB-Instance-on-Docker/


echo "Creating mongo users..."

#mongo admin --host localhost --port 27017 -u root -p rootPassHERE --eval \
#"db.createUser(
#  {
#    user: 'admin',
#    pwd: 'adminPass',
#    roles: [ {role: 'userAdminAnyDatabase',
#              db: 'admin'} ]
#  }
#);"

mongo admin --host localhost --port 27017 -u root -p rootPassHERE << EOF
use mydb
db.createUser(
  {
    user: "user1",
    pwd: "user1Pass",
    roles:[ {role: "readWrite",
             db: "mydb"} ]
  }
)
db.createUser(
  {
    user: "user2",
    pwd: "user2Pass",
    roles:[ {role: "readWrite",
             db: "mydb"} ]
  }
)
EOF

echo "Mongo users created."
