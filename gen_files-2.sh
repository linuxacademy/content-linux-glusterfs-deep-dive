#!/bin/bash

#wait for volume to be created
until [ -f /tmp/disperse_done ] ;
do
	sleep 5
done

#start the GlusterFS volume
gluster volume start gfs_vol

#mount the volume locally
mount -t glusterfs server-1:/gfs_vol /mnt

#generate a number of files with random sizes in a range
min=15      # min size (MB)
max=50     # max size (MB)
nofiles=50 # number of files

for i in `eval echo {1..$nofiles}`
do
    dd bs=1M count=$(($RANDOM%max + $min)) if=/dev/urandom of=/mnt/file-$i &>/dev/null & disown;
done

touch /tmp/files_done
