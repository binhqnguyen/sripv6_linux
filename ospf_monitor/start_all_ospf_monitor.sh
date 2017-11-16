#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
SSH_ARGS=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
for i in  2 3 4 7
do
	echo -e "\n========================="
	echo "Start OSPF monitor on node $i ..."
	#ssh node$i.$domain "cd ~/sripv6-linux/ospf_monitor/; nohup sudo ./start_monitor.sh 2>&1 &"
	scp $SSH_ARGS -r ~/sripv6-linux/ospf_monitor node$i.$domain:~/
	ssh $SSH_ARGS node$i.$domain "cd ~/ospf_monitor/; sudo screen -S ospf_monitor -d -m ./start_monitor.sh $hn 8080"
done

echo "DONE starting OSPF monitors on all nodes!"
exit 0
