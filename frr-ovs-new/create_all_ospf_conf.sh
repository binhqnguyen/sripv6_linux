#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
SSH_ARGS=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
for i in 2 3 4 7
do
	echo -e "\n========================="
	echo "Create OSPF conf of node $i ..."
	scp $SSH_ARGS net_info.sh create_ospf_conf.sh node$i.$domain:~/ > /dev/null
	ssh $SSH_ARGS node$i.$domain "./create_ospf_conf.sh"
done

echo "DONE installing OSPF6 conf files on all nodes!"
exit 0
