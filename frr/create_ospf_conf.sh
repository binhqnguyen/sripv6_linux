#!/bin/bash
source net_info.sh
OSPF="ospf6d.conf"
ETC="/usr/local/etc/"


META="hostname ospf6d@plant\npassword zebra\nlog file ospf6.log\nservice advanced-vty\n!"
echo "!" > $OSPF
echo -e $META >> $OSPF

#NODE2
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node2" ]; then
	echo "#Node $hn..."
	echo "interface $n2_a_dev" >> $OSPF
	echo "interface $n2_b_dev" >> $OSPF
	echo "interface $n2_c_dev" >> $OSPF
	echo "interface lo" >> $OSPF
	echo "router ospf6" >> $OSPF
	echo "   router-id 0.0.0.2" >> $OSPF
	echo "   area 0.0.0.0 range $n2_a/80" >> $OSPF
	echo "	 interface $n2_a_dev area 0.0.0.0" >> $OSPF
	echo "   area 0.0.0.0 range $n2_b/80" >> $OSPF
	echo "	 interface $n2_b_dev area 0.0.0.0" >> $OSPF
	echo "   area 0.0.0.0 range $n2_c/80" >> $OSPF
	echo "	 interface $n2_c_dev area 0.0.0.0" >> $OSPF
fi


#NODE3
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node3" ]; then
	echo "#Node $hn..."
	echo "interface $n3_b_dev" >> $OSPF
	echo "interface $n3_d_dev" >> $OSPF
	echo "interface $n3_e_dev" >> $OSPF
	echo "interface lo" >> $OSPF
	echo "router ospf6" >> $OSPF
	echo "   router-id 0.0.0.3" >> $OSPF
	echo "   area 0.0.0.0 range $n3_b/80" >> $OSPF
	echo "	 interface $n3_b_dev area 0.0.0.0" >> $OSPF
	echo "   area 0.0.0.0 range $n3_d/80" >> $OSPF
	echo "	 interface $n3_d_dev area 0.0.0.0" >> $OSPF
	echo "   area 0.0.0.0 range $n3_e/80" >> $OSPF
	echo "	 interface $n3_e_dev area 0.0.0.0" >> $OSPF
fi


#NODE4
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node4" ]; then
	echo "#Node $hn..."
	echo "interface $n4_c_dev" >> $OSPF
	echo "interface $n4_d_dev" >> $OSPF
	echo "interface lo" >> $OSPF
	echo "router ospf6" >> $OSPF
	echo "   router-id 0.0.0.4" >> $OSPF
	echo "   area 0.0.0.0 range $n4_c/80" >> $OSPF
	echo "	 interface $n4_c_dev area 0.0.0.0" >> $OSPF
	echo "   area 0.0.0.0 range $n4_d/80" >> $OSPF
	echo "	 interface $n4_d_dev area 0.0.0.0" >> $OSPF
fi

echo "line vty" >> $OSPF

cat $OSPF
sudo cp $OSPF $ETC
exit 0
