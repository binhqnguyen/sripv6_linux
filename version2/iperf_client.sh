#!/bin/bash
source net_info.sh

iperf -u -V -c $n5_e -b 1000m
