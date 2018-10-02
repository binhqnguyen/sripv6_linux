## OSPF monitor

Overview:
=======
This repo contains an implementation of OSPF monitor and scripts to set up an IPv6 topology for segment routing tutorial.
* Tutorial link: http://www.cs.utah.edu/~binh/archive/segment_routing/segment-routing-tutorial.html

Usage:
=====
* Topology in PhantomNet (or CloudLab): name "sripv6"
https://www.phantomnet.org/show-profile.php?uuid=1a298a72-22fc-11e7-91c5-90e2ba22fee4

* Scripts to run OSPF + SR using Free Range Routing: in `frr` folder.

* **Steps:** 
    * Get the interfaces IP, MAC, dev name on each node by running: `./get_all_info.sh on NODE1.` 
	  OR do it manually - change the file net_info.sh manually to include the correct IPV6, MAC address, and device name for all of the nodes in the topology. This information is used to install routes on the node for SR.
	* Install globally routable IPV6 addresses for interfaces on the nodes: `./add_global_ipv6.sh`
	* Install the "uplink" path (from node1 to node4's netd): `./install_uplink_path.sh`
	* Install the "downlink" returning path (from node4's netc directly to node1's netc): `./install_downlink_path.sh`

Note:
====
* Caviats: As the "downlink" uses a different interface (netc) instead of the incomming interface (netd), ONLY stateless connections work (eg, ICMP, UDP). Iperf won't work because it uses stateful TCP connections.
* Newer Version: a more sophisticated topology, in `version2` folder.

