#!/bin/bash

#deploy and run myself
echo "#!/bin/bash" > net_info.sh


SSH_ARGS=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
GET_INTERFACES_HELPER="$HOME/get_interface_map.pl"

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
echo "Get info of node $hn ..."
cp get_interface_map.pl $HOME/
./get_info.sh >> net_info.sh


for i in 0 2 3 4 5 6
do
	echo "Get info of node $i ..."
	scp get_info.sh node$i.$domain:~/ > /dev/null
  	scp ${GET_INTERFACES_HELPER} node${i}.$domain:~/ > /dev/null
	ssh ${SSH_ARGS} node$i.$domain "./get_info.sh" >> net_info.sh
done



echo "DONE. See net_info.sh"
