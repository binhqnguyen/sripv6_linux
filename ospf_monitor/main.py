# !/usr/bin/env python

import sys, select
from lsa_receiver import *
sys.path.insert(0, '/users/binh/sripv6-linux/ospf_monitor/lib')
from ospfv3 import *

if __name__ == "__main__":


    global VERBOSE, DUMP_MRTD, ADDRESS

    VERBOSE   = 1
    DUMP_MRTD = 0
    ADDRESS   = "::"

    LSAA_HOST = "155.98.39.112"
    LSAA_PORT = 5002
    #lsar = LSAR("155.98.39.112", 8080)
    lsar = LSAR(LSAA_HOST, LSAA_PORT)


    #---------------------------------------------------------------------------

    ospf       = Ospfv3(ADDRESS)

    try:
        timeout = Ospfv3._holdtimer

        rv = None
        while 1:

	    rv = ospf.parseMsg(VERBOSE, 0)
	    if MSG_TYPES[int(rv['T'])] == "LSUPD": 
	    	lsar.print_ospf_json(rv, VERBOSE, 0)
	    	lsar.send_ospf_msg(rv)

    except (KeyboardInterrupt):
        ospf.close()
        sys.exit(1)
