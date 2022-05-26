#!/bin/bash

#install gnupg and Add gluster GPG key to apt
apt -y install gnupg
wget -O - https://download.gluster.org/pub/gluster/glusterfs/10/rsa.pub | apt-key add -

#Set variables to be used in source URL
DEBID=$(grep 'VERSION_ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
DEBVER=$(grep 'VERSION=' /etc/os-release | grep -Eo '[a-z]+')
DEBARCH=$(dpkg --print-architecture)

#Create gluster source list for apt
echo deb https://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/${DEBID}/${DEBARCH}/apt ${DEBVER} main > /etc/apt/sources.list.d/gluster.list

#Update apt and install glusterfs-server
apt update
apt install -y glusterfs-server

#enable and start the glusterd service
systemctl enable --now  glusterd
