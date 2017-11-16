#!/bin/bash

hn=$(hostname | awk -F'.' '{print $1}')
domain=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')

#NODE1
if [ "$hn" == "node1" ]; then
	echo "Start OVS on Node $hn..."
	cd /opt/openvswitch; sudo ./re_compile.sh
	cd /opt/openvswitch; sudo ./run_ovs.sh
	sudo ./run_srv6.sh net1 neta 127.0.0.1
fi

#NODE5
if [ "$hn" == "node5" ]; then
	echo "Start OVS on Node $hn..."
	cd /opt/openvswitch; sudo ./re_compile.sh
	cd /opt/openvswitch; sudo ./run_ovs.sh
	sudo ./run_srv6.sh net2 neta $(host node1.$domain | grep "has address" | awk -F" " '{print $4}')
fi

exit 0
