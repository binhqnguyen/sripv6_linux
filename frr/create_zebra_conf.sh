#!/bin/bash
source net_info.sh
ZEBRA="zebra.conf"
ETC="/usr/local/etc/"

META="hostname Router\n
password zebra\n
enable password zebra\n
log file zebra.log\n!"
LB="interface lo\n
ip forwarding\n
line vty"
echo "!" > $ZEBRA
echo -e $META >> $ZEBRA


#NODE2
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node2" ]; then
	echo "#Node $hn..."
	echo "interface $n2_a_dev" >> $ZEBRA
	echo "   ipv6 address $n2_a/80" >> $ZEBRA
	echo "interface $n2_b_dev" >> $ZEBRA
	echo "   ipv6 address $n2_b/80" >> $ZEBRA
	echo "interface $n2_c_dev" >> $ZEBRA
	echo "   ipv6 address $n2_c/80" >> $ZEBRA
fi


#NODE3
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node3" ]; then
	echo "#Node $hn..."
	echo "interface $n3_b_dev" >> $ZEBRA
	echo "   ipv6 address $n3_b/80" >> $ZEBRA
	echo "interface $n3_d_dev" >> $ZEBRA
	echo "   ipv6 address $n3_d/80" >> $ZEBRA
	echo "interface $n3_e_dev" >> $ZEBRA
	echo "   ipv6 address $n3_e/80" >> $ZEBRA

fi


#NODE4
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node4" ]; then
	echo "#Node $hn..."
	echo "interface $n4_c_dev" >> $ZEBRA
	echo "   ipv6 address $n4_c/80" >> $ZEBRA
	echo "interface $n4_d_dev" >> $ZEBRA
	echo "   ipv6 address $n4_d/80" >> $ZEBRA
fi

echo -e $LB >> $ZEBRA
cat $ZEBRA
sudo cp $ZEBRA $ETC
exit 0
