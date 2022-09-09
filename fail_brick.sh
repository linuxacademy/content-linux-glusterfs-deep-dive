#!/bin/bash

#locate device to fail
DEVICE=$(lsblk -l -o NAME,KNAME,SUBSYSTEMS,PATH,MOUNTPOINT | grep gfs | awk '{print$4}' | sed -e 's~p1~~')

#determine the device subsystem and slot
SUBSYS=$(nvme list-subsys ${DEVICE} | grep pcie | awk '{print $4}' | cut -d . -f 1)
SLOT=$(grep "${SUBSYS}" /sys/bus/pci/slots/*/add* | cut -d : -f 1)

#Fail the drive.
echo echo "0 > /sys/bus/pci/slots/${SLOT}/power"
#echo 0 > /sys/bus/pci/slots/${SLOT}/power

