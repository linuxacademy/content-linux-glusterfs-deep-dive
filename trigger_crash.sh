#!/bin/bash

status=5
while [ $status -ne 0 ]
 do
	 echo "in the loop"
	 sleep 5
	 check=$(gluster volume info | grep -i started)
	 status=$?
done

umount /mnt
sleep 3

ssh server-4 -q screen -d -m /root/crash.sh
