#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
SSH_ARGS=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
for i in  2 3 4 7
do
	echo -e "\n========================="
	echo "Kill FRR on node $i ..."
	scp $SSH_ARGS kill_frr.sh start_frr.sh node$i.$domain:~/ > /dev/null
	ssh $SSH_ARGS node$i.$domain "sudo ./kill_frr.sh"
done
