#!/bin/bash

#generate a number of files with random sizes in a range
min=15      # min size
max=50     # max size
nofiles=50 # number of files

for i in `eval echo {1..$nofiles}`
do
    dd bs=1M count=$(($RANDOM%max + $min)) if=/dev/urandom of=/mnt/file-$i &>/dev/null & disown;
done

status=5
while [ $status -ne 1 ]
 do
   echo  -ne "\033[31;40mcreating files, please wait...\033[0m\r"
   sleep 1
   check=$(ps -ef | grep -i "[d]d bs=" )
   status=$?
done
echo -ne "\n"
echo -ne "\033[32;40mfiles created \033[0m\n"
