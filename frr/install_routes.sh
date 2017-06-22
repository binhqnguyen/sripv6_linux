#!/bin/bash

#Install routes for each node in the topology. This should be done using a routing 
#protocol such as OSPF or ISIS.
#
#Topology:
#                    
#                              |---(netb)---node3----(nete)---node5
#     node1---(neta)---node2 --|             |
#                              |             |
#                              |            (netd)
#                              |             |
#			       |---(netc)---node4
#

source net_info.sh

SSH_SD="ssh -t -t"


#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')

#----------node1-----------------
echo ""
echo "Install routes on source node1"
echo "--------------------------------------"
#ip route to node 5:
$SSH_SD node1.$DOMAIN "sudo ip -6 route add $n5_e/128 dev $n1_a_dev"
#arp to node 5 via node 2:
$SSH_SD node1.$DOMAIN "sudo ip -6 neigh add $n5_e lladdr $n2_a_mac dev $n1_a_dev"
#if rerun the arp assignment, need to use "replace"
$SSH_SD node1.$DOMAIN "sudo ip -6 neigh replace $n5_e lladdr $n2_a_mac dev $n1_a_dev"

#----------node2-------------
echo ""
echo "Install routes on node2"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interfaces
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.$n2_a_dev.seg6_enabled=1"
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.$n2_b_dev.seg6_enabled=1"
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.$n2_c_dev.seg6_enabled=1"
#arp for node5
$SSH_SD node2.$DOMAIN "sudo ip -6 neigh add $n5_e lladdr $n4_c_mac dev $n2_c_dev"
$SSH_SD node2.$DOMAIN "sudo ip -6 neigh add $n5_e lladdr $n3_b_mac dev $n2_b_dev"
$SSH_SD node2.$DOMAIN "sudo ip -6 neigh add $n1_a lladdr $n1_a_mac dev $n2_a_dev"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD node2.$DOMAIN "sudo ip -6 route add $n4_c/128 dev $n2_c_dev"
$SSH_SD node2.$DOMAIN "sudo ip -6 route add $n3_b/128 dev $n2_b_dev"
$SSH_SD node2.$DOMAIN "sudo ip -6 route add $n1_a/128 dev $n2_a_dev"


#----------node3-------------
echo ""
echo "Install routes on node3"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.$n3_b_dev.seg6_enabled=1"
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.$n3_d_dev.seg6_enabled=1"
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.$n3_e_dev.seg6_enabled=1"
#arp for the next segment
$SSH_SD node3.$DOMAIN "sudo ip -6 neigh add $n1_a lladdr $n2_b_mac dev $n3_b_dev"
$SSH_SD node3.$DOMAIN "sudo ip -6 neigh add $n1_a lladdr $n4_d_mac dev $n3_d_dev"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD node3.$DOMAIN  "sudo ip -6 route add $n2_b/128 dev $n3_b_dev"
$SSH_SD node3.$DOMAIN  "sudo ip -6 route add $n4_d/128 dev $n3_d_dev"
$SSH_SD node3.$DOMAIN  "sudo ip -6 route add $n5_e/128 dev $n3_e_dev"




#--------node4--------------
echo ""
echo "Install routes on node4"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.$n4_c_dev.seg6_enabled=1"
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.$n4_d_dev.seg6_enabled=1"
#arp for the next segment
$SSH_SD node4.$DOMAIN "sudo ip -6 neigh add $n1_a lladdr $n2_c_mac dev $n4_c_dev"
$SSH_SD node4.$DOMAIN "sudo ip -6 neigh add $n5_e lladdr $n3_d_mac dev $n4_d_dev"
#ip forwarding for pkts to next-hop (encapsulated pkt's destination)
$SSH_SD node4.$DOMAIN  "sudo ip -6 route add $n3_d/128 dev $n4_d_dev"
$SSH_SD node4.$DOMAIN  "sudo ip -6 route add $n2_c/128 dev $n4_c_dev"


#----------node5-----------------
echo ""
echo "Install routes on source node5"
echo "--------------------------------------"
#ip route to node 1:
$SSH_SD node5.$DOMAIN "sudo ip -6 route add $n1_a/128 dev $n5_e_dev"
#arp to node 5 via node 2:
$SSH_SD node5.$DOMAIN "sudo ip -6 neigh add $n1_a lladdr $n3_e_mac dev $n5_e_dev"
#if rerun the arp assignment, need to use "replace"
$SSH_SD node5.$DOMAIN "sudo ip -6 neigh replace $n1_a lladdr $n3_e_mac dev $n5_e_dev"


