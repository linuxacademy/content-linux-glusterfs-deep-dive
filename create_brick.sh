#!/bin/bash

#Partition disk
/usr/sbin/parted --script -a optimal -- /dev/nvme1n1 mklabel gpt mkpart primary 1MiB -1
sleep 2

#Create Filesystem
mkfs.xfs -i size=512 /dev/nvme1n1p1

#add to /etc/fstab, mount filesystem, and create brick subdirectory
UUID=`blkid /dev/nvme1n1p1 | cut -d \" -f 2`
echo "UUID=$UUID /gfs xfs rw,inode64,noatime,nouuid 1 2" >> /etc/fstab
mkdir /gfs
mount /gfs
mkdir /gfs/brick-1
