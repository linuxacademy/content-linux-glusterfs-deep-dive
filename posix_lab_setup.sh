#!/bin/bash

#create the mountpoint
mkdir /finance

#wait until volume is created
until [ -f /tmp/disperse_done ] ;
do
	sleep 5
done

#start the GlusterFS volume
gluster volume start gfs_vol

#mount the volume locally
mount -t glusterfs server-1:/gfs_vol /finance

#Setup directory structure and ownerships
chmod 771 /finance
mkdir -p /finance/bonuses /finance/payroll /finance/sales_projects/red-jet-racing /finance/sales_projects/llama-racing
chown finance:finance /finance /finance/payroll /finance/bonuses
chown -R finance:sales /finance/sales_projects
chmod -R 770 /finance/*
chown finance:finance /finance

echo "1 - Go Fast
2 - Win" >> /finance/sales_projects/llama-racing/Secret-Racing-Strategy.txt

chown finance:sales /finance/sales_projects/llama-racing/Secret-Racing-ad-campaign.txt
chmod 666 /finance/sales_projects/llama-racing/Secret-Racing-ad-campaign.txt

touch /tmp/posix_lab_done
