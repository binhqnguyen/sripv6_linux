#!/bin/bash
LB_IP=197
INF="$HOME/get_interface_map.pl"

#NODE0
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node0" ]; then
	echo "#Node $hn..."
	n0_1_dev=$($INF | grep net1 | awk '{print $3}')
	n0_1_mac=$(ifconfig | grep $n0_1_dev | awk '{print $5}')
	n0_1=$(ifconfig | grep -A3 $n0_1_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::204:/ )
	let lb=$LB_IP+0
	echo "n0_lb=\"$lb::1\""
	echo "n0_1=\"$n0_1\""
	echo "n0_1_mac=\"$n0_1_mac\""
	echo "n0_1_dev=\"$n0_1_dev\""
fi



#NODE1
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node1" ]; then
	echo "#Node $hn..."
	n1_a_dev=$($INF | grep neta | awk '{print $3}')
	n1_a_mac=$(ifconfig | grep $n1_a_dev | awk '{print $5}')
	n1_a=$(ifconfig | grep -A3 $n1_a_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::204:/ )
	n1_1_dev=$($INF | grep net1 | awk '{print $3}')
	n1_1_mac=$(ifconfig | grep $n1_1_dev | awk '{print $5}')
	n1_1=$(ifconfig | grep -A3 $n1_1_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::204:/ )
	n1_pub=$(ifconfig | grep -A3 "eth0" | grep "inet addr" | awk '{print $2}' | awk -F":" '{print $2}')
	let lb=$LB_IP+1
	echo "n1_lb=\"$lb::1\""
	echo "n1_a=\"$n1_a\""
	echo "n1_a_mac=\"$n1_a_mac\""
	echo "n1_a_dev=\"$n1_a_dev\""
	echo "n1_1=\"$n1_1\""
	echo "n1_1_mac=\"$n1_1_mac\""
	echo "n1_1_dev=\"$n1_1_dev\""
	echo "n1_pub=\"$n1_pub\""

fi


#NODE2
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node2" ]; then
	echo "#Node $hn..."
	n2_a_dev=$($INF | grep neta | awk '{print $3}')
	n2_a_mac=$(ifconfig | grep $n2_a_dev | awk '{print $5}')
	n2_a=$(ifconfig | grep -A3 $n2_a_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::204:/ )

	n2_b_dev=$($INF | grep netb | awk '{print $3}')
	n2_b_mac=$(ifconfig | grep $n2_b_dev | awk '{print $5}')
	n2_b=$(ifconfig | grep -A3 $n2_b_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::205:/ )

	n2_c_dev=$($INF | grep netc | awk '{print $3}')
	n2_c_mac=$(ifconfig | grep $n2_c_dev | awk '{print $5}')
	n2_c=$(ifconfig | grep -A3 $n2_c_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::206:/ )

	let lb=$LB_IP+2
	echo "n2_lb=\"$lb::1\""
	echo "n2_a=\"$n2_a\""
	echo "n2_a_mac=\"$n2_a_mac\""
	echo "n2_a_dev=\"$n2_a_dev\""
	echo "n2_b=\"$n2_b\""
	echo "n2_b_mac=\"$n2_b_mac\""
	echo "n2_b_dev=\"$n2_b_dev\""
	echo "n2_c=\"$n2_c\""
	echo "n2_c_mac=\"$n2_c_mac\""
	echo "n2_c_dev=\"$n2_c_dev\""
fi


#NODE3
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node3" ]; then
	echo "#Node $hn..."
	n3_b_dev=$($INF | grep netb | awk '{print $3}')
	n3_b_mac=$(ifconfig | grep $n3_b_dev | awk '{print $5}')
	n3_b=$(ifconfig | grep -A3 $n3_b_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::205:/ )

	n3_d_dev=$($INF | grep netd | awk '{print $3}')
	n3_d_mac=$(ifconfig | grep $n3_d_dev | awk '{print $5}')
	n3_d=$(ifconfig | grep -A3 $n3_d_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::207:/ )

	n3_e_dev=$($INF | grep nete | awk '{print $3}')
	n3_e_mac=$(ifconfig | grep $n3_e_dev | awk '{print $5}')
	n3_e=$(ifconfig | grep -A3 $n3_e_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::208:/ )


	n3_g_dev=$($INF | grep netg | awk '{print $3}')
	n3_g_mac=$(ifconfig | grep $n3_g_dev | awk '{print $5}')
	n3_g=$(ifconfig | grep -A3 $n3_g_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::210:/ )


	let lb=$LB_IP+3
	echo "n3_lb=\"$lb::1\""
	echo "n3_b=\"$n3_b\""
	echo "n3_b_mac=\"$n3_b_mac\""
	echo "n3_b_dev=\"$n3_b_dev\""
	echo "n3_d=\"$n3_d\""
	echo "n3_d_mac=\"$n3_d_mac\""
	echo "n3_d_dev=\"$n3_d_dev\""
	echo "n3_e=\"$n3_e\""
	echo "n3_e_mac=\"$n3_e_mac\""
	echo "n3_e_dev=\"$n3_e_dev\""
	echo "n3_g=\"$n3_g\""
	echo "n3_g_mac=\"$n3_g_mac\""
	echo "n3_g_dev=\"$n3_g_dev\""
fi


#NODE4
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node4" ]; then
	echo "#Node $hn..."
	n4=$($INF)
	n4_c_dev=$($INF | grep netc | awk '{print $3}')
	n4_c_mac=$(ifconfig | grep $n4_c_dev | awk '{print $5}')
	n4_c=$(ifconfig | grep -A3 $n4_c_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::206:/ )

	n4_d_dev=$($INF | grep netd | awk '{print $3}')
	n4_d_mac=$(ifconfig | grep $n4_d_dev | awk '{print $5}')
	n4_d=$(ifconfig | grep -A3 $n4_d_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*/2001::207:/ )

	n4_f_dev=$($INF | grep netf | awk '{print $3}')
	n4_f_mac=$(ifconfig | grep $n4_f_dev | awk '{print $5}')
	n4_f=$(ifconfig | grep -A3 $n4_f_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*/2001::209:/ )


	let lb=$LB_IP+4
	echo "n4_lb=\"$lb::1\""
	echo "n4_c=\"$n4_c\""
	echo "n4_c_mac=\"$n4_c_mac\""
	echo "n4_c_dev=\"$n4_c_dev\""
	echo "n4_d=\"$n4_d\""
	echo "n4_d_mac=\"$n4_d_mac\""
	echo "n4_d_dev=\"$n4_d_dev\""
	echo "n4_f=\"$n4_f\""
	echo "n4_f_mac=\"$n4_f_mac\""
	echo "n4_f_dev=\"$n4_f_dev\""

fi

#NODE7
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node7" ]; then
	echo "#Node $hn..."
	n7=$($INF)
	n7_f_dev=$($INF | grep netf | awk '{print $3}')
	n7_f_mac=$(ifconfig | grep $n7_f_dev | awk '{print $5}')
	n7_f=$(ifconfig | grep -A3 $n7_f_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::209:/ )

	n7_g_dev=$($INF | grep netg | awk '{print $3}')
	n7_g_mac=$(ifconfig | grep $n7_g_dev | awk '{print $5}')
	n7_g=$(ifconfig | grep -A3 $n7_g_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*/2001::210:/ )

	let lb=$LB_IP+7
	echo "n7_lb=\"$lb::1\""
	echo "n7_f=\"$n7_f\""
	echo "n7_f_mac=\"$n7_f_mac\""
	echo "n7_f_dev=\"$n7_f_dev\""
	echo "n7_g=\"$n7_g\""
	echo "n7_g_mac=\"$n7_g_mac\""
	echo "n7_g_dev=\"$n7_g_dev\""
fi



#NODE5
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node5" ]; then
	echo "#Node $hn..."
	n5_e_dev=$($INF | grep nete | awk '{print $3}')
	n5_e_mac=$(ifconfig | grep $n5_e_dev | awk '{print $5}')
	n5_e=$(ifconfig | grep -A3 $n5_e_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::208:/ )
	n5_2_dev=$($INF | grep net2 | awk '{print $3}')
	n5_2_mac=$(ifconfig | grep $n5_2_dev | awk '{print $5}')
	n5_2=$(ifconfig | grep -A3 $n5_2_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::208:/ )
	n5_pub=$(ifconfig | grep -A3 "eth0" | grep "inet addr" | awk '{print $2}' | awk -F":" '{print $2}')
	let lb=$LB_IP+5
	echo "n5_lb=\"$lb::1\""
	echo "n5_e=\"$n5_e\""
	echo "n5_e_mac=\"$n5_e_mac\""
	echo "n5_e_dev=\"$n5_e_dev\""
	echo "n5_2=\"$n5_2\""
	echo "n5_2_mac=\"$n5_2_mac\""
	echo "n5_2_dev=\"$n5_2_dev\""
	echo "n5_pub=\"$n5_pub\""

fi


#NODE6
hn=$(hostname | awk -F'.' '{print $1}')
if [ "$hn" == "node6" ]; then
	echo "#Node $hn..."
	n6_2_dev=$($INF | grep net2 | awk '{print $3}')
	n6_2_mac=$(ifconfig | grep $n6_2_dev | awk '{print $5}')
	n6_2=$(ifconfig | grep -A3 $n6_2_dev | grep inet6 | grep "fe80::" | awk '{print $3}' | awk -F'/' '{print $1}' | sed s/fe80::*:/2001::208:/ )
	let lb=$LB_IP+6
	echo "n6_lb=\"$lb::1\""
	echo "n6_2=\"$n6_2\""
	echo "n6_2_mac=\"$n6_2_mac\""
	echo "n6_2_dev=\"$n6_2_dev\""
fi


