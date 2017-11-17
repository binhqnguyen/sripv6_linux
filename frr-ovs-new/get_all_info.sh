#!/bin/bash

#deploy and run myself
echo "#!/bin/bash" > net_info.sh


SSH_ARGS=" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "
GET_INTERFACES_HELPER="get_interface_map.pl"

hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
echo "Get info of node $hn ..."
./get_info.sh >> net_info.sh


for i in 0 2 3 4 5 6 7
do
	echo "Get info of node $i ..."
	scp $SSH_ARGS get_info.sh node$i.$domain:~/ > /dev/null
  	scp $SSH_ARGS ${GET_INTERFACES_HELPER} node${i}.$domain:~/ > /dev/null
	ssh -t -t ${SSH_ARGS} node$i.$domain "sudo chmod +x $GET_INTERFACES_HELPER; ./get_info.sh" >> net_info.sh
done

/usr/bin/dos2unix net_info.sh

echo "DONE. See net_info.sh"
