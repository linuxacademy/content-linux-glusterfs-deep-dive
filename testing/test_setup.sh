#!/bin/bash

#Add /etc/hosts entries
echo "10.0.2.101 server-1
10.0.2.102 server-2
10.0.2.103 server-3
10.0.2.104 server-4
10.0.2.105 server-5
10.0.2.106 server-6" >> /etc/hosts

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
