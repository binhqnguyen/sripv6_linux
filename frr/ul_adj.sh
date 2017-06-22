#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
SRC_NODE="node1.$DOMAIN"
INGRESS_NODE="node2.$DOMAIN"

#IP and interfaces
DST_IP=$n5_e

#segments
MID_SEGS=("$n4_c" "$n3_d") #via node2's netc adjacency and node4.
MID_SEG_DEVS="$n2_c_dev"




#----------node2 (ingress)-------------
echo ""
echo "Install rules on ingress nodes $INGRESS_NODE"
echo "--------------------------------------"
#ip forwarding for pkts to DST_IP
$SSH_SD $INGRESS_NODE "sudo ip -6 route add $DST_IP/128 dev $MID_SEG_DEVS encap seg6 mode encap segs ${MID_SEGS[0]},${MID_SEGS[1]}"
