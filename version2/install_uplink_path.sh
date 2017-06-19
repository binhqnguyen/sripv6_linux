#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
SRC_NODE="node1.$DOMAIN"
MID_NODES=("node4.$DOMAIN")
EGRESS_NODE="node3.$DOMAIN"
INGRESS_NODE="node2.$DOMAIN"

#IP and interfaces
SRC_IP=$n1_a
SRC_MAC=$n1_a_mac
SRC_DEV=$n1_a_dev
DST_IP=$n5_e
DST_MAC=$n5_e_mac
DST_DEV=$n5_e_dev

#segments
MID_SEGS=("$n4_c" "$n3_d") #via node2's netc adjacency and node4.
MID_SEG_MACS=("$n4_c_mac" "$n3_d_mac")
MID_SEG_DEVS=("$n2_c_dev" "$n4_d_dev")
MID_NODE_SRH_INFS=("$n4_c_dev")
INGRESS_INF="$n2_a_dev"

#egress DEV (to destination)
EGRESS_DEV=$n3_e_dev
#egress DEV (receiving)
EGRESS_DEV_IN=$n3_d_dev


#----------node1-----------------
echo ""
echo "Install rules on source node $SRC_NODE"
echo "--------------------------------------"
#ip route to node 5:
$SSH_SD $SRC_NODE "sudo ip -6 route add $DST_IP/128 dev $SRC_DEV"
#arp to node 5 via node 2:
$SSH_SD $SRC_NODE "sudo ip -6 neigh add $DST_IP lladdr $n2_a_mac dev $SRC_DEV"
#if rerun the arp assignment, need to use "replace"
$SSH_SD $SRC_NODE "sudo ip -6 neigh replace $DST_IP lladdr $n2_a_mac dev $SRC_DEV"

#----------node2 (ingress)-------------
echo ""
echo "Install rules on ingress nodes $INGRESS_NODE"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD $INGRESS_NODE "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD $INGRESS_NODE "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD $INGRESS_NODE "sudo sysctl net.ipv6.conf.$INGRESS_INF.seg6_enabled=1"
#ip forwarding for pkts to DST_IP
$SSH_SD $INGRESS_NODE "sudo ip -6 route add $DST_IP/128 dev ${MID_SEG_DEVS[0]} encap seg6 mode encap segs ${MID_SEGS[0]},${MID_SEGS[1]}"
#arp for DST_IP
$SSH_SD $INGRESS_NODE "sudo ip -6 neigh add $DST_IP lladdr ${MID_SEG_MACS[0]} dev ${MID_SEG_DEVS[0]}"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD $INGRESS_NODE "sudo ip -6 route add ${MID_SEGS[0]}/128 dev ${MID_SEG_DEVS[0]}"


#----------node4 (core node)-------------
echo ""
echo "Install rules on core nodes ${MID_NODES[0]}"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD ${MID_NODES[0]} "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD ${MID_NODES[0]} "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD ${MID_NODES[0]} "sudo sysctl net.ipv6.conf.${MID_NODE_SRH_INFS[0]}.seg6_enabled=1"
#arp for the next segment
$SSH_SD ${MID_NODES[0]} "sudo ip -6 neigh add ${MID_SEGS[1]} lladdr ${MID_SEG_MACS[1]} dev ${MID_SEG_DEVS[1]}"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD ${MID_NODES[0]} "sudo ip -6 route add ${MID_SEGS[1]}/128 dev ${MID_SEG_DEVS[1]}"




#--------node3 (egress)--------------
echo ""
echo "Install rules on egress node $EGRESS_NODE"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD $EGRESS_NODE "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD $EGRESS_NODE "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD $EGRESS_NODE "sudo sysctl net.ipv6.conf.$EGRESS_DEV_IN.seg6_enabled=1"
#ip forwarding for pkts to DST_IP.
$SSH_SD $EGRESS_NODE "sudo ip -6 route add $DST_IP/128 dev $EGRESS_DEV"
#arp for DST_IP
$SSH_SD $EGRESS_NODE "sudo ip -6 neigh add $DST_IP lladdr $DST_MAC dev $EGRESS_DEV"
