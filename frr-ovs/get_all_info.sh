#!/bin/bash

#deploy and run myself
echo "#!/bin/bash" > net_info.sh


hn=$(hostname)
domain=$(echo $hn | awk -F'.' '{print $2"."$3"."$4"."$5}')
echo "Get info of node $hn ..."
./get_info.sh >> net_info.sh


for i in 0 2 3 4 5 6
do
	echo "Get info of node $i ..."
	scp get_info.sh node$i.$domain:~/ > /dev/null
	ssh node$i.$domain "./get_info.sh" >> net_info.sh
done

echo "DONE. See net_info.sh"
