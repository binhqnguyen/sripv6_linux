#!/bin/bash

hn=$(hostname)
for i in 2 3 4 
do
	echo -e "\n========================="
	echo "Create OSPF conf of node $i ..."
	scp net_info.sh create_ospf_conf.sh node$i:~/ > /dev/null
	ssh node$i "./create_ospf_conf.sh"
done

echo "DONE installing OSPF6 conf files on all nodes!"
exit 0
