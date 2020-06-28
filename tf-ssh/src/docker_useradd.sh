#!/bin/bash
# Create users and groups when starting a new container

# add user ("uid", "gid" and "user" need user to change)
# you can use group settings to grant different privileges in hosts and containers
groupadd -g gid1 user1 \
    && useradd -m -u uid1 -g gid1 -G sudo -s /bin/bash user1 \
    && echo 'user1:pw12345678' | chpasswd
groupadd -g gid2 user2 \
    && useradd -m -u uid2 -g gid2 -G sudo -s /bin/bash user2 \
    && echo 'user2:pw23456789' | chpasswd
groupadd -g gid3 user3 \
    && useradd -m -u uid3 -g gid3 -G sudo -s /bin/bash user3 \
    && echo 'user3:pw34567890' | chpasswd