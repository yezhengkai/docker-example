#!/bin/bash

# Add user ("uid", "gid", "username" and "password" need to be set by administrator)
# you can use group settings to grant different privileges in hosts and containers
groupadd -g 1001 user1 \
    && useradd -m -u 1001 -g 1001 -G sudo -s /bin/bash user1 \
    && echo 'user1:user1Pass' | chpasswd
groupadd -g 1002 user2 \
    && useradd -m -u 1002 -g 1002 -G sudo -s /bin/bash user2 \
    && echo 'user2:user2Pass' | chpasswd

