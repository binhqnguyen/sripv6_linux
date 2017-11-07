#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
for i in  2 3 4 
do
	echo -e "\n========================="
	echo "Start OSPF monitor on node $i ..."
	#ssh node$i.$domain "cd ~/sripv6-linux/ospf_monitor/; nohup sudo ./start_monitor.sh 2>&1 &"
	ssh node$i.$domain "cd ~/sripv6-linux/ospf_monitor/; sudo ./kill_monitor.sh"
done

echo "DONE starting OSPF monitors on all nodes!"
exit 0
