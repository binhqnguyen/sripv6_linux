# !/usr/bin/env python

import sys, select
sys.path.insert(0, '/users/binh/ospf_monitor/lib')
from ospfv3 import *

if __name__ == "__main__":

    #import mrtd

    global VERBOSE, DUMP_MRTD, ADDRESS

    VERBOSE   = 3
    DUMP_MRTD = 0
    ADDRESS   = "::"

    #mrtd_type = None

    #---------------------------------------------------------------------------

    ospf       = Ospfv3(ADDRESS)

    try:
        timeout = Ospfv3._holdtimer

        rv = None
        while 1:
            #rfds, _, _ = select.select([ospf._sock], [], [], timeout)

	    rv = ospf.parseMsg(VERBOSE, 0)
	    if rv:
		print rv["T"]
            #if len(rfds) > 0:
	    #	print "receive OSPF"
	    #	rv = ospf.parseMsg(VERBOSE, 0)
            #else:
	    #	print "receiveX"
            #    ## tx some pkts to form adjacency
            #    pass

    except (KeyboardInterrupt):
        ospf.close()
        sys.exit(1)
