#!/bin/bash

#Install cloudformation helper scripts
mkdir -p /opt/aws/bin
/usr/bin/wget https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz
python3 -m easy_install --script-dir /opt/aws/bin aws-cfn-bootstrap-py3-latest.tar.gz


for OPT in "$@"
do
	if [ "$OPT" == "linstor" ]; then
	 wget -qO - https://github.com/linuxacademy/content-linux-glusterfs-deep-dive/raw/main/linstor_install.sh | bash
	 	until [ -f /tmp/linstor_done ];
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
