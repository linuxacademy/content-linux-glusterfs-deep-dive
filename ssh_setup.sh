#!/bin/bash

#enable root login with pass and key authentication
/usr/bin/sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
/usr/bin/sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
/usr/bin/sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
/usr/bin/sed -i 's/#Banner none/Banner \/etc\/motd/g' /etc/ssh/sshd_config
echo "Welcome to $HOSTNAME" > /etc/motd
systemctl --no-block --no-pager restart ssh
touch /tmp/ssh_setup_done
