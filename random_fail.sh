#!/bin/bash

#set number of hosts
hosts=6
die1=0

#fail a device on random serve
let "die1 = $RANDOM % $hosts +1"
let "result = $die1"
ssh server-${result} /root/fail_brick.sh
