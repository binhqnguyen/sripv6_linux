#!/bin/bash

hn=$(hostname)
for i in 2 3 4 
do
	echo -e "\n========================="
	echo "Start FRR on node $i ..."
	scp kill_frr.sh start_frr.sh node$i:~/ > /dev/null
	ssh node$i "sudo ./start_frr.sh"
done

echo "DONE starting FRR on all nodes!"
exit 0
