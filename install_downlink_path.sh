#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
SRC_NODE="node1.$DOMAIN"
MID_NODES=("node2.$DOMAIN")
EGRESS_NODE="node3.$DOMAIN"
DST_NODE="node4.$DOMAIN"

#IP and interfaces
SRC_IP=$n1_a
SRC_MAC=$n1_c_mac
DST_DEV=$n4_c_dev #going back on node4's netc.

#----------dst node-----------------
echo ""
echo "Install rules on destination node for returning path $DST_NODE"
echo "--------------------------------------"
#ip route to node 4:
$SSH_SD $DST_NODE "sudo ip -6 route add $SRC_IP/128 dev $DST_DEV"
#arp to node 4 via node 2:
$SSH_SD $DST_NODE "sudo ip -6 neigh add $SRC_IP lladdr $SRC_MAC dev $DST_DEV"

