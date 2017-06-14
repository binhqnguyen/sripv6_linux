#!/bin/bash

#deploy and run myself
echo "#!/bin/bash" > net_info.sh

hn=$(hostname)
echo "Get info of node $hn ..."
./get_info.sh >> net_info.sh


for i in 2 3 4
do
	echo "Get info of node $i ..."
	scp get_info.sh node$i:~/ > /dev/null
	ssh node$i "./get_info.sh" >> net_info.sh
done

echo "DONE. See net_info.sh"
