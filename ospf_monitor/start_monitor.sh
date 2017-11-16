#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: <OSPF LSA listener, eg, node1.srv6.phantomnet.emulab.net> <OSPF LSA listener's port number, eg, 8080>"
	exit 1
fi
ps ax | grep main.py | grep -v grep | awk '{print $1; system("sudo kill -9 " $1)}'
sudo python main.py $1 $2
