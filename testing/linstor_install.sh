#!/bin/bash

#Add ppa repository
add-apt-repository -y ppa:linbit/linbit-drbd9-stack
apt-get update

#install drbd and linstor
export DEBIAN_FRONTEND=noninteractive
apt-get install -y drbd-dkms drbd-utils lvm2 linstor-satellite linstor-client
if [ "$HOSTNAME" = server-1 ]; then
	apt-get install -y linstor-controller
else
	echo "Not server-1"
fi

#reload drbd module to make sure new version is used
rmmod drbd
modprobe drbd

touch /tmp/linstor_done
