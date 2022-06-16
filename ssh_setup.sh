#!/bin/bash

#enable root login with pass and key authentication
/usr/bin/sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
/usr/bin/sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart ssh

if [ "$HOSTNAME" = server-1 ]; then

#Generate key
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

#copy keys to rest of the servers
for host in {1..6}; do

sshpass -f /root/cloud_pass ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa root@10.0.2.10${i}
scp /root/.ssh/id_rsa* 10.0.2.10${i}:/root/.ssh/
done

#add key locally
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
else
echo "nothing to do"
fi

