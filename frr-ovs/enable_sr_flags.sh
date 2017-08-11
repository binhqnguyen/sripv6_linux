#!/bin/bash

#Install forwarding flags on OSPF routers to enable Segment Routing.
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

#----------node2-------------
echo ""
echo "Enable SR flags on router node2"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interfaces
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.$n2_a_dev.seg6_enabled=1"
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.$n2_b_dev.seg6_enabled=1"
$SSH_SD node2.$DOMAIN "sudo sysctl net.ipv6.conf.$n2_c_dev.seg6_enabled=1"


#----------node3-------------
echo ""
echo "Enable SR flags on router node3"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.$n3_b_dev.seg6_enabled=1"
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.$n3_d_dev.seg6_enabled=1"
$SSH_SD node3.$DOMAIN "sudo sysctl net.ipv6.conf.$n3_e_dev.seg6_enabled=1"




#--------node4--------------
echo ""
echo "Enable SR flags on router node4"
echo "--------------------------------------"
#enable IPV6 forwarding
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.all.forwarding=1"
#enable SRH processing flag on node
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.all.seg6_enabled=1"
#enable SRH processing flag on interface
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.$n4_c_dev.seg6_enabled=1"
$SSH_SD node4.$DOMAIN "sudo sysctl net.ipv6.conf.$n4_d_dev.seg6_enabled=1"
