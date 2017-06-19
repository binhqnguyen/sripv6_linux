#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
SRC_NODE="node1.$DOMAIN"
MID_NODES=("node2.$DOMAIN" "node4.$DOMAIN")
EGRESS_NODE="node3.$DOMAIN"


#IP and interfaces
SRC_IP=$n1_a
SRC_MAC=$n1_a_mac
SRC_DEV=$n1_a_dev
DST_IP=$n5_e
DST_MAC=$n5_e_mac
DST_DEV=$n5_e_dev

#segments
MID_SEGS=("$n4_c" "$n3_lb") #via node2's netb adjacency and node3.
MID_SEG_MACS=("$n4_c_mac" "$n3_d_mac")
MID_SEG_DEVS=("$n2_c_dev" "$n4_d_dev")
MID_NODE_SRH_INFS=("$n2_a_dev" "$n4_c_dev")

#egress DEV (to destination)
EGRESS_DEV=$n3_e_dev
#egress DEV (receiving)
EGRESS_DEV_IN=$n3_d_dev


#----------node1-----------------
echo ""
echo "Install rules on source node $SRC_NODE"
echo "--------------------------------------"
#ip route to node 5:
$SSH_SD $SRC_NODE "sudo ip -6 route del $DST_IP/128 dev $SRC_DEV"
#arp to node 5 via node 2:
$SSH_SD $SRC_NODE "sudo ip -6 neigh del $DST_IP lladdr $n2_a_mac dev $SRC_DEV"

#----------node2 (ingress)-------------
echo ""
echo "Install rules on ingress nodes ${MID_NODES[0]}"
echo "--------------------------------------"
#ip forwarding for pkts to DST_IP
$SSH_SD ${MID_NODES[0]} "sudo ip -6 route del $DST_IP/128 dev ${MID_SEG_DEVS[0]} encap seg6 mode encap segs $MID_SEGS"
#arp for DST_IP
$SSH_SD ${MID_NODES[0]} "sudo ip -6 neigh del $DST_IP lladdr ${MID_SEG_MACS[0]} dev ${MID_SEG_DEVS[0]}"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD ${MID_NODES[0]} "sudo ip -6 route del ${MID_SEGS[0]}/128 dev ${MID_SEG_DEVS[0]}"


#----------node4 (core node)-------------
echo ""
echo "Install rules on core nodes ${MID_NODES[1]}"
echo "--------------------------------------"
#arp for the next segment (eg, node3's loopback)
$SSH_SD ${MID_NODES[0]} "sudo ip -6 neigh del ${MIG_SEGS[1]} lladdr ${MID_SEG_MACS[1]} dev ${MID_SEG_DEVS[1]}"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD ${MID_NODES[0]} "sudo ip -6 route del ${MID_SEGS[1]}/128 dev ${MID_SEG_DEVS[1]}"




#--------node3 (egress)--------------
echo ""
echo "Install rules on egress node $EGRESS_NODE"
echo "--------------------------------------"
#ip forwarding for pkts to DST_IP.
$SSH_SD $EGRESS_NODE "sudo ip -6 route del $DST_IP/128 dev $EGRESS_DEV"
#arp for DST_IP
$SSH_SD $EGRESS_NODE "sudo ip -6 neigh del $DST_IP lladdr $DST_MAC dev $EGRESS_DEV"
