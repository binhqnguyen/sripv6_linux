#!/bin/bash

hn=$(hostname)
for i in 2 3 4 
do
	echo -e "\n=========================="
	echo "Create zebra conf of node $i ..."
	scp net_info.sh create_zebra_conf.sh node$i:~/ > /dev/null
	ssh node$i "./create_zebra_conf.sh"
done

echo "DONE installing Zebra conf files on all nodes!"
exit 0
