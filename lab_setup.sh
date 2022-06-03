#!/bin/bash

#Add /etc/hosts entries
echo "10.0.2.101 server-1
10.0.2.102 server-2
10.0.2.103 server-3
10.0.2.104 server-4" >> /etc/hosts

#restart glusterd due to some intermittent issues on lab starting.
systemctl --no-pager --no-block restart glusterd
sleep 5

if [ "$HOSTNAME" = server-1 ]; then
gluster peer probe server-2
gluster peer probe server-3
gluster peer probe server-4
else
echo "nothing to do"
fi

/usr/bin/wget https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/iptables.sh 
chmod +X /root/iptables.sh
/root/iptables.sh
sleep 10
