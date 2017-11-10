#!/bin/bash

for i in zebra ospf6
do
	ps ax | grep "$i" | grep -v "grep" | awk '{system("kill -9 " $1)}'
done
