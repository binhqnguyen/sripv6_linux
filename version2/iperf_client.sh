#!/bin/bash
source net_info.sh

iperf -V -M 1350 -c $n5_e
