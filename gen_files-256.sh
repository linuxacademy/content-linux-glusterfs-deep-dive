#!/bin/bash

#generate a number of files with random sizes in a range
min=15      # min size (MB)
max=50     # max size (MB)
nofiles=500 # number of files

for i in `eval echo {1..$nofiles}`
do
    dd bs=256 count=$(($RANDOM%max + $min)) if=/dev/urandom of=/mnt/file-$i &>/dev/null & disown;
done

touch /tmp/files_done
