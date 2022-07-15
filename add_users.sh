#!/bin/bash

groupadd -g 1030 sales
groupadd -g 1031 finance
useradd -u 1005 -d /home/finance -M -s /usr/sbin/nologin -g finance finance
useradd -u 1006 -d /home/consultant  -m -s /bin/bash consultant

touch /tmp/users_done
