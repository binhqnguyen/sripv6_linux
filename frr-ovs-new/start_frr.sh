#!/bin/bash

if [ "$(whoami)" != "root" ]; then
        echo "Must run as root: sudo <cmd>"
        exit 1
fi

export LD_LIBRARY_PATH=/usr/local/lib
sudo chmod 777 /var/run/
sudo chmod 777 /var/run/
sudo chmod 755 /var/run/sshd #for ssh access.
sudo chmod 644 /var/run/sshd.pid

sudo sysctl net.ipv6.conf.all.forwarding=1 #enable ip forwarding for fe80:: addresses

./kill_frr.sh

for i in zebra ospf6d
do
        $i -d;
        ps ax | grep $i
done

