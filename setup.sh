#!/bin/bash

#Install cloudformation helper scripts
mkdir -p /opt/aws/bin
/usr/bin/wget https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz
python3 -m easy_install --script-dir /opt/aws/bin aws-cfn-bootstrap-py3-latest.tar.gz


for OPT in "$@"
do
	if [ "$OPT" == "gfs" ]; then
	 wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/gfs_install.sh | bash
	 	until [ -f /tmp/gfs_install_done ];
			do
			sleep 3
	 	done
	elif [ "$OPT" == "ipt" ]; then
	 wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/iptables.sh | bash
                until [ -f /tmp/iptables_done ];
                        do
                        sleep 3
                done
	elif [ "$OPT" == "pool3" ]; then
	 wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/lab_setup_3_node.sh | bash 
                until [ -f /tmp/lab_setup_done ];
                        do
                        sleep 3
                done
        elif [ "$OPT" == "pool4" ]; then
         wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/lab_setup_4_node.sh | bash
                until [ -f /tmp/lab_setup_done ];
                        do
                        sleep 3
                done
        elif [ "$OPT" == "pool6" ]; then
         wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/lab_setup_6_node.sh | bash
                until [ -f /tmp/lab_setup_done ];
                        do
                        sleep 3
                done
        elif [ "$OPT" == "ssh" ]; then
         wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/ssh_setup.sh | bash
                until [ -f /tmp/ssh_setup_done ];
                        do
                        sleep 3
                done
	else echo bad 
	fi
done

touch /tmp/setup_done
