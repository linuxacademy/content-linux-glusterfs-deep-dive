#!/bin/bash

/root/create_brick.sh
until [ -f /tmp/brick_done ];
        do
          sleep 3
        done
gluster volume create ganesha_vol disperse 4 redundancy 1 server-1:/gfs/brick-1 server-2:/gfs/brick-1 server-3:/gfs/brick-1 server-4:/gfs/brick-1 
