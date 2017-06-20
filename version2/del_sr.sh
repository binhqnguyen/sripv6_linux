#!/bin/bash

source net_info.sh

SSH_SD="ssh -t -t"

#Node name for SSH
DOMAIN=$(hostname | awk -F'.' '{print $2"."$3"."$4"."$5}')
INGRESS_NODES=("node2" "node3")
DST_IPS=($n5_e $n1_a)

#----------node2 (ingress)-------------
echo ""
echo "Delete SR rules on ingress nodes "${INGRESS_NODES[@]}""
echo "--------------------------------------"
#ip forwarding for pkts to DST_IP
$SSH_SD ${INGRESS_NODES[0]}.$DOMAIN "sudo ip -6 route del ${DST_IPS[0]}/128"
$SSH_SD ${INGRESS_NODES[1]}.$DOMAIN "sudo ip -6 route del ${DST_IPS[1]}/128"

