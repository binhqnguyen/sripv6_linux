#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
SRC_NODE="node1.$DOMAIN"
MID_NODES=("node2.$DOMAIN")
EGRESS_NODE="node3.$DOMAIN"


#IP and interfaces
SRC_IP=$n1_a
SRC_MAC=$n1_a_mac
SRC_DEV=$n1_a_dev
DST_IP=$n4_d
DST_MAC=$n4_d_mac
DST_DEV=$n4_d_dev

#segments
MID_SEGS="$n3_b" #via this node(s).
MID_SEG_MACS=($n3_b_mac)
MID_SEG_DEVS=($n2_b_dev)
MID_NODE_SRH_INFS=($n3_b_dev)

#egress DEV (to destination)
EGRESS_DEV=$n3_d_dev
#egress DEV (receiving)
EGRESS_DEV_IN=$n3_b_dev


#----------node1-----------------
echo ""
echo "Install rules on source node $SRC_NODE"
echo "--------------------------------------"
#ip route to node 4:
$SSH_SD $SRC_NODE "sudo ip -6 route add $DST_IP/128 dev $SRC_DEV"
#arp to node 4 via node 2:
$SSH_SD $SRC_NODE "sudo ip -6 neigh add $DST_IP lladdr $n2_a_mac dev $SRC_DEV"


#----------node2 (ingress)-------------
echo ""
echo "Install rules on middle nodes $MID_NODES"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD ${MID_NODES[0]} "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD ${MID_NODES[0]} "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD ${MID_NODES[0]} "sudo sysctl net.ipv6.conf.${MID_NODE_SRH_INFS[0]}.seg6_enabled=1"
#ip forwarding for pkts to DST_IP
$SSH_SD ${MID_NODES[0]} "sudo ip -6 route add $DST_IP/128 dev ${MID_SEG_DEVS[0]} encap seg6 mode encap segs $MID_SEGS"
#arp for DST_IP
$SSH_SD ${MID_NODES[0]} "sudo ip -6 neigh add $DST_IP lladdr ${MID_SEG_MACS[0]} dev ${MID_SEG_DEVS[0]}"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD ${MID_NODES[0]} "sudo ip -6 route add ${MID_SEGS[0]}/128 dev ${MID_SEG_DEVS[0]}"


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
