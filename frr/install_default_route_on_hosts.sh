#!/bin/bash
source net_info.sh

SSH_SD="ssh -t -t"


#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')

$SSH_SD node1.$DOMAIN "sudo ip -6 route add $n5_e/80 dev $n1_a_dev"
$SSH_SD node1.$DOMAIN "sudo ip -6 neigh add $n5_e lladdr $n2_a_mac dev $n1_a_dev"
$SSH_SD node1.$DOMAIN "sudo ip -6 neigh replace $n5_e lladdr $n2_a_mac dev $n1_a_dev"

$SSH_SD node5.$DOMAIN "sudo ip -6 route add $n1_a/80 dev $n5_e_dev"
$SSH_SD node5.$DOMAIN "sudo ip -6 neigh add $n1_a dev $n5_e_dev"
$SSH_SD node5.$DOMAIN "sudo ip -6 neigh replace $n1_a lladdr $n3_e_mac dev $n5_e_dev"
