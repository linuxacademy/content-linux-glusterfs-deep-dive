#!/bin/bash

until [ -f /tmp/brick_done ];
        do
          sleep 3
        done
for host in {1..4}; do
attempt=0
while [ $attempt -le 10 ]; do
ssh -o KbdInteractiveAuthentication=no -o BatchMode=yes 10.0.2.10${host} 2>&1 ls /tmp/brick_done || test $? -eq 0 && break
sleep 6
let attempt=attempt+1
done
done

#Enough attempts to validate brick, just create the volume win or lose.
gluster volume create gfs_vol replica 4 server-1:/gfs/brick-1 server-2:/gfs/brick-1 server-3:/gfs/brick-1 server-4:/gfs/brick-1

sleep 3
gluster volume start gfs_vol

touch /tmp/replica4_done
