# !/usr/bin/env python

import sys, json, requests
import subprocess
from lib.ospfv3 import *

class LSAR(object):
	
	def __init__(self, dst_ip, dst_port):
		self.dst_ip = dst_ip
		self.dst_port = dst_port

	def print_ospf_json(self, ospf_msg, verbose=1, level=0):
		json_s = json.dumps(ospf_msg, ensure_ascii=False)
		if verbose > 1:
			print (level+1)*INDENT + json_s

	def send_ospf_msg(self, ospf_msg):
		uri = 'http://%s:%s/ospf_monitor/lsa_put' % (self.dst_ip, self.dst_port)
		try:
			r = requests.post(uri, data=json.dumps(ospf_msg))
			if (r.status_code != 200):
				print "Sent OSPF message to %s,return code = %s" % (uri, r.status_code)
		except:
			print "Can't send OSPF message to %s (server is not running?)" % (uri)
			pass
	

	
