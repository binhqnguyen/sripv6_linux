#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
SRC_NODE="node5.$DOMAIN"
INGRESS_NODE="node3.$DOMAIN"

#IP and interfaces
DST_IP=$n1_a

#segments
MID_SEGS=("$n2_lb") #via node3's netd adjacency and node2.
MID_SEG_DEVS="$n3_b_dev" #this is bogus. But the ip route command seems to need this to pass the format check.




#----------node3 (ingress)-------------
echo ""
echo "Install rules on ingress nodes $INGRESS_NODE"
echo "--------------------------------------"
#ip forwarding for pkts to DST_IP
$SSH_SD $INGRESS_NODE "sudo ip -6 route add $DST_IP/128 dev $MID_SEG_DEVS encap seg6 mode encap segs ${MID_SEGS[0]}"
