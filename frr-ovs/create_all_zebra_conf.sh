#!/bin/bash

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')

for i in 1 2 3 4 5
do
	echo -e "\n=========================="
	echo "Create zebra conf of node $i ..."
	scp net_info.sh create_zebra_conf.sh node$i.$domain:~/ > /dev/null
	ssh node$i.$domain "./create_zebra_conf.sh"
done

echo "DONE installing Zebra conf files on all nodes!"
exit 0
