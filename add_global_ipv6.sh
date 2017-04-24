#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')

#----------node1---------
echo "Add IPv6 addresses on node 1"
$SSH_SD "node1.$DOMAIN" "sudo ip -6 addr add $n1_a dev $n1_a_dev"
$SSH_SD "node1.$DOMAIN" "sudo ip -6 addr add $n1_c dev $n1_c_dev"

#----------node2---------
echo "Add IPv6 addresses on node 2"
$SSH_SD "node2.$DOMAIN" "sudo ip -6 addr add $n2_a dev $n2_a_dev"
$SSH_SD "node2.$DOMAIN" "sudo ip -6 addr add $n2_b dev $n2_b_dev"


#----------node3---------
echo "Add IPv6 addresses on node 3"
$SSH_SD "node3.$DOMAIN" "sudo ip -6 addr add $n3_b dev $n3_b_dev"
$SSH_SD "node3.$DOMAIN" "sudo ip -6 addr add $n3_d dev $n3_d_dev"

#----------node4---------
echo "Add IPv6 addresses on node 4"
$SSH_SD "node4.$DOMAIN" "sudo ip -6 addr add $n4_d dev $n4_d_dev"
$SSH_SD "node4.$DOMAIN" "sudo ip -6 addr add $n4_c dev $n4_c_dev"

