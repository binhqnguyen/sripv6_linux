#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
for i in 2 3 4 7
do
	echo -e "\n========================="
	echo "Create OSPF conf of node $i ..."
	scp net_info.sh create_ospf_conf.sh node$i.$domain:~/ > /dev/null
	ssh node$i.$domain "./create_ospf_conf.sh"
done

echo "DONE installing OSPF6 conf files on all nodes!"
exit 0
