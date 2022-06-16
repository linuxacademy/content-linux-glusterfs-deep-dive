#!/bin/bash

if [ "$HOSTNAME" = server-1 ]; then
sleep 10
#Generate key
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
ssh-keygen -b 2048 -t rsa -f /home/cloud_user/.ssh/id_rsa -q -N ""
chmod 0400 /home/cloud_user/.ssh/id_rsa
chown cloud_user:cloud_user /home/cloud_user/.ssh/id_rsa

#copy keys to rest of the servers
for host in {1..6}; do
attempt=0
while [ $attempt -le 10 ]; do
ssh -o KbdInteractiveAuthentication=no -o BatchMode=yes setup@10.0.2.10${host} 2>&1 | grep server || test $? -eq 0 && break
sleep 6
let attempt=attempt+1
done
sshpass -f /root/cloud_pass ssh-copy-id -f -o StrictHostKeyChecking=no -i /root/.ssh/id_rsa root@10.0.2.10${host}
sshpass -f /root/cloud_pass ssh-copy-id -f -o StrictHostKeyChecking=no -i /home/cloud_user/.ssh/id_rsa cloud_user@10.0.2.10${host}
scp /root/.ssh/id_rsa* 10.0.2.10${host}:/root/.ssh/
scp /home/cloud_user/.ssh/id_rsa* 10.0.2.10${host}:/home/cloud_user/.ssh/
ssh 10.0.2.10${host} 'chown cloud_user:cloud_user /home/cloud_user/.ssh/id_rsa*'
done

else
echo "nothing to do"
fi
