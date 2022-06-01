#!/bin/bash

#Add /etc/hosts entries
echo "10.0.2.100 server-1\n10.0.2.101 server-2\n10.0.2.102 server-3\n10.0.2.103 server-4" >> /etc/hosts

#Add cloud_user ssh keys for passwordless ssh
if [ "$HOSTNAME" = server-1 ]; then
ssh-keygen -t rsa -N "" /home/cloud_user/.ssh/id_rsa
chmod 0400 /home/cloud_user/.ssh/id_rsa /home/cloud_user/.ssh/id_rsa.pub
chown cloud_user:cloud_user /home/cloud_user/.ssh/id_rsa /home/cloud_user/.ssh/id_rsa.pub
else
echo "nothing to do"
fi


#Copy key to other systems.
for i in {1..4}
do
sshpass -f /root/cloud_pass ssh-copy-id -i /home/cloud_user/.ssh/id_rsa.pub -o "StrictHostKeyChecking no" cloud_user@server-${i}
scp /home/cloud_user/.ssh/id_rsa cloud_user@server-${i}:/home/cloud_user/.ssh/id_rsa
done

if [ "$HOSTNAME" = server-1 ]; then
gluster peer probe server-2
gluster peer probe server-3
gluster peer probe server-4
else
echo "nothing to do"
fi

