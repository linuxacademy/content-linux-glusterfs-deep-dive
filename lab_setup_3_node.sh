#!/bin/bash

#Add /etc/hosts entries
echo "10.0.2.101 server-1
10.0.2.102 server-2
10.0.2.104 server-3" >> /etc/hosts

#Check for iptables file and add glusterfs port 24007
if [ -f /tmp/iptables_done ]; then
 iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 24007 -j ACCEPT
 iptables -A OUTPUT -p tcp -m state --state NEW -m tcp --dport 24007 -j ACCEPT
else
echo no iptables
fi

#restart glusterd due to some intermittent issues on lab starting.
systemctl --no-pager --no-block restart glusterd
sleep 10 

if [ "$HOSTNAME" = server-1 ]; then
sleep 45 
gluster peer probe server-2
gluster peer probe server-3
else
echo "nothing to do"
fi

touch /tmp/lab_setup_done
