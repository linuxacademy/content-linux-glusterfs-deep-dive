#!/bin/bash

#Partition disk
/usr/sbin/parted --script -a optimal -- /dev/nvme1n1 mklabel gpt mkpart primary 1MiB -1
sleep 2

#Create Filesystem
mkfs.xfs -i size=512 /dev/nvme1n1p1 

#mount filesystem and create brick subdirectory
mkdir /gfs
mount /dev/nvme1n1p1 /gfs
mkdir /gfs/brick-1
