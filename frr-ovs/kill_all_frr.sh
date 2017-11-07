#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
for i in  2 3 4 
do
	echo -e "\n========================="
	echo "Kill FRR on node $i ..."
	scp kill_frr.sh start_frr.sh node$i.$domain:~/ > /dev/null
	ssh node$i.$domain "sudo ./kill_frr.sh"
done
