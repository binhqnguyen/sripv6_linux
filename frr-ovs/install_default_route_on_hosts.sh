#!/bin/bash
source net_info.sh

SSH_SD="ssh -t -t"


#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')

$SSH_SD node0.$DOMAIN "sudo ip -6 route add $n6_2/80 dev $n0_1_dev"
$SSH_SD node0.$DOMAIN "sudo ip -6 neigh add $n6_2 lladdr $n1_1_mac dev $n0_1_dev"
$SSH_SD node0.$DOMAIN "sudo ip -6 neigh replace $n6_2 lladdr $n1_1_mac dev $n0_1_dev"

$SSH_SD node6.$DOMAIN "sudo ip -6 route add $n0_1/80 dev $n6_2_dev"
$SSH_SD node6.$DOMAIN "sudo ip -6 neigh add $n0_1 dev $n6_2_dev"
$SSH_SD node6.$DOMAIN "sudo ip -6 neigh replace $n0_1 lladdr $n5_2_mac dev $n6_2_dev"
