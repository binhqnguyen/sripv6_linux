#!/bin/bash
source net_info.sh
ZEBRA="zebra.conf"
ETC="/usr/local/etc/"

META="hostname Router\n
password zebra\n
enable password zebra\n
log file /users/quagga/zebra.log\n!"
#LB="interface lo\n
LB="ip forwarding\n
line vty"
echo "!" > $ZEBRA
echo -e $META >> $ZEBRA

#NODE1
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node1" ]; then
	echo "#Node $hn..."
	echo "interface $n1_a_dev" >> $ZEBRA
	echo "   ipv6 address $n1_a/80" >> $ZEBRA
	echo "interface $n1_1_dev" >> $ZEBRA
	echo "   ipv6 address $n1_1/80" >> $ZEBRA
	echo "interface lo" >> $ZEBRA
	echo "   ipv6 address $n1_lb/80" >> $ZEBRA
fi



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
	echo "interface lo" >> $ZEBRA
	echo "   ipv6 address $n2_lb/80" >> $ZEBRA
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
	echo "interface $n3_g_dev" >> $ZEBRA
	echo "   ipv6 address $n3_g/80" >> $ZEBRA
	echo "interface lo" >> $ZEBRA
	echo "   ipv6 address $n3_lb/80" >> $ZEBRA
fi


#NODE4
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node4" ]; then
	echo "#Node $hn..."
	echo "interface $n4_c_dev" >> $ZEBRA
	echo "   ipv6 address $n4_c/80" >> $ZEBRA
	echo "interface $n4_d_dev" >> $ZEBRA
	echo "   ipv6 address $n4_d/80" >> $ZEBRA
	echo "interface $n4_f_dev" >> $ZEBRA
	echo "   ipv6 address $n4_f/80" >> $ZEBRA
	echo "interface lo" >> $ZEBRA
	echo "   ipv6 address $n4_lb/80" >> $ZEBRA
fi

#NODE7
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node7" ]; then
	echo "#Node $hn..."
	echo "interface $n7_f_dev" >> $ZEBRA
	echo "   ipv6 address $n7_f/80" >> $ZEBRA
	echo "interface $n7_g_dev" >> $ZEBRA
	echo "   ipv6 address $n7_g/80" >> $ZEBRA
	echo "interface lo" >> $ZEBRA
	echo "   ipv6 address $n7_lb/80" >> $ZEBRA
fi

#NODE5
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node5" ]; then
	echo "#Node $hn..."
	echo "interface $n5_e_dev" >> $ZEBRA
	echo "   ipv6 address $n5_e/80" >> $ZEBRA
	echo "interface $n5_2_dev" >> $ZEBRA
	echo "   ipv6 address $n5_2/80" >> $ZEBRA
	echo "interface lo" >> $ZEBRA
	echo "   ipv6 address $n5_lb/80" >> $ZEBRA
fi



echo -e $LB >> $ZEBRA
cat $ZEBRA
sudo cp $ZEBRA $ETC
exit 0
