#!/bin/bash

#deploy and run myself
SSH_ARGS=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
domain=$(echo $(hostname) | awk -F'.' '{print $2"."$3"."$4"."$5}')

for i in 1 5
do
	echo "Start OVS node $i ..."
	scp $SSH_ARGS start_ovs.sh node$i.$domain:~/ > /dev/null
	ssh -t -t ${SSH_ARGS} node$i.$domain "cd ~/; ./start_ovs.sh"
done

exit 0
