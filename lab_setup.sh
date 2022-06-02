#!/bin/bash

#Add /etc/hosts entries
echo "10.0.2.101 server-1
10.0.2.102 server-2
10.0.2.103 server-3
10.0.2.104 server-4" >> /etc/hosts

#Add cloud_user ssh keys for passwordless ssh
if [ "$HOSTNAME" = server-1 ]; then
ssh-keygen -t rsa -N "" -f /home/cloud_user/.ssh/id_rsa
chmod 0400 /home/cloud_user/.ssh/id_rsa /home/cloud_user/.ssh/id_rsa.pub
chown cloud_user:cloud_user /home/cloud_user/.ssh/id_rsa /home/cloud_user/.ssh/id_rsa.pub
cat /home/cloud_user/id_rsa.pub >> /home/cloud_user/authorized_keys
else
echo "nothing to do"
fi


#Sleep to allow instances to fully startup then copy key to other systems.
sleep 60
for i in {2..4}
do
sshpass -f /root/cloud_pass ssh-copy-id -i /home/cloud_user/.ssh/id_rsa.pub -o "StrictHostKeyChecking no" cloud_user@server-${i}
scp -o "StrictHostKeyChecking no" -i /home/cloud_user/.ssh/id_rsa /home/cloud_user/.ssh/id_rsa cloud_user@server-${i}:/home/cloud_user/.ssh/id_rsa
done

if [ "$HOSTNAME" = server-1 ]; then
gluster peer probe server-2
gluster peer probe server-3
gluster peer probe server-4
else
echo "nothing to do"
fi

#get new glusterd.vol file for port ranges.
/usr/bin/wget https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/glusterd.vol -P /etc/glusterfs/
/usr/bin/systemctl restart glusterd
