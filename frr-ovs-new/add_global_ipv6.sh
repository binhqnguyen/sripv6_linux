#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')

#----------node0---------
echo "Add IPv6 addresses on node 0"
$SSH_SD "node0.$DOMAIN" "sudo ip -6 addr add $n0_1 dev $n0_1_dev"
#$SSH_SD "node1.$DOMAIN" "sudo ip -6 addr add $n1_lb dev lo"


#----------node1---------
#echo "Add IPv6 addresses on node 1"
#$SSH_SD "node1.$DOMAIN" "sudo ip -6 addr add $n1_a dev $n1_a_dev"
#$SSH_SD "node1.$DOMAIN" "sudo ip -6 addr add $n1_lb dev lo"

#----------node2---------
echo "Add IPv6 addresses on node 2"
#$SSH_SD "node2.$DOMAIN" "sudo ip -6 addr add $n2_a dev $n2_a_dev"
#$SSH_SD "node2.$DOMAIN" "sudo ip -6 addr add $n2_b dev $n2_b_dev"
$SSH_SD "node2.$DOMAIN" "sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga; sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga  quagga"
$SSH_SD "node2.$DOMAIN" "sudo ip -6 addr add $n2_lb dev lo"


#----------node3---------
echo "Add IPv6 addresses on node 3"
#$SSH_SD "node3.$DOMAIN" "sudo ip -6 addr add $n3_b dev $n3_b_dev"
#$SSH_SD "node3.$DOMAIN" "sudo ip -6 addr add $n3_d dev $n3_d_dev"
#$SSH_SD "node3.$DOMAIN" "sudo ip -6 addr add $n3_e dev $n3_e_dev"
$SSH_SD "node3.$DOMAIN" "sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga; sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga  quagga"
$SSH_SD "node3.$DOMAIN" "sudo ip -6 addr add $n3_lb dev lo"

#----------node4---------
echo "Add IPv6 addresses on node 4"
#$SSH_SD "node4.$DOMAIN" "sudo ip -6 addr add $n4_d dev $n4_d_dev"
#$SSH_SD "node4.$DOMAIN" "sudo ip -6 addr add $n4_c dev $n4_c_dev"
$SSH_SD "node4.$DOMAIN" "sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga; sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga  quagga"
$SSH_SD "node4.$DOMAIN" "sudo ip -6 addr add $n4_lb dev lo"

#----------node7---------
echo "Add IPv6 addresses on node 7"
$SSH_SD "node7.$DOMAIN" "sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga; sudo adduser --home /users/quagga --disabled-password --gecos \"\" quagga  quagga"
$SSH_SD "node7.$DOMAIN" "sudo ip -6 addr add $n7_lb dev lo"


#----------node5---------
#echo "Add IPv6 addresses on node 5"
#$SSH_SD "node5.$DOMAIN" "sudo ip -6 addr add $n5_e dev $n5_e_dev"
#$SSH_SD "node5.$DOMAIN" "sudo ip -6 addr add $n5_lb dev lo"

#----------node6---------
echo "Add IPv6 addresses on node 6"
$SSH_SD "node6.$DOMAIN" "sudo ip -6 addr add $n6_2 dev $n6_2_dev"
#$SSH_SD "node5.$DOMAIN" "sudo ip -6 addr add $n5_lb dev lo"

