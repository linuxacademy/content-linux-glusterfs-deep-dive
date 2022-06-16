#!/bin/bash

#enable root login with pass and key authentication
/usr/bin/sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
/usr/bin/sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
/usr/bin/sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
systemctl restart ssh

if [ "$HOSTNAME" = server-1 ]; then

#Generate key
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
ssh-keygen -b 2048 -t rsa -f /home/cloud_user/.ssh/id_rsa -q -N ""
chmod 0400 /home/cloud_user/.ssh/id_rsa
chown cloud_user:cloud_user /home/cloud_user/.ssh/id_rsa

#copy keys to rest of the servers
for host in {1..6}; do

sshpass -f /root/cloud_pass ssh-copy-id -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa root@10.0.2.10${host}
sshpass -f /root/cloud_pass ssh-copy-id -o StrictHostKeyChecking=no -i /home/cloud_user/.ssh/id_rsa cloud_user@10.0.2.10${host}
scp /root/.ssh/id_rsa* 10.0.2.10${host}:/root/.ssh/
scp /home/cloud_user/.ssh/id_rsa* 10.0.2.10${host}:/home/cloud_user/.ssh/
done

#add key locally
#cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
else
echo "nothing to do"
fi

