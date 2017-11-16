# !/usr/bin/env python

import sys, select
from lsa_receiver import *
from lib.ospfv3 import *

if __name__ == "__main__":


    global VERBOSE, DUMP_MRTD, ADDRESS

    VERBOSE   = 1
    DUMP_MRTD = 0
    ADDRESS   = "::"

    if len(sys.argv) != 3:
	print "Usage: <OSPF listener's host, eg, node1.srv6.phantomnet.emulab.net> <OSPF listener's port number, eg, 8080>"
	sys.exit(1)

    LSAA_HOST = sys.argv[1]
    LSAA_PORT = int(sys.argv[2])
    #lsar = LSAR("155.98.39.112", 8080)
    lsar = LSAR(LSAA_HOST, LSAA_PORT)


    #---------------------------------------------------------------------------

    ospf       = Ospfv3(ADDRESS)

    try:
        timeout = Ospfv3._holdtimer

        rv = None
        while 1:

	    rv = ospf.parseMsg(VERBOSE, 0)
	    if MSG_TYPES[int(rv['T'])] == "LSUPD" or MSG_TYPES[int(rv['T'])] == "HELLO":
		lsar.print_ospf_json(rv, VERBOSE, 0)
		lsar.send_ospf_msg(rv)

    except (KeyboardInterrupt):
        ospf.close()
        sys.exit(1)
