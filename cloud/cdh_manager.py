#!/bin/python
#Install client: sudo pip install cm-api
#if you don't have pip: sudo apt-get install python-pip
#Install from source:
#git clone git://github.com/cloudera/cm_api.git
#cd cm_api/python
#sudo python setup.py install
######################WARNING###########################
#This tool is not backward compatible, it means if you
#are not using the latest CM, you have to pull previous
#related brunch and install from the source!
########################################################



import time
import sys
from cm_api.api_client import ApiResource

if len(sys.argv)<5:
	print 'Plz provide host ip, port, username and pwd'
	sys.exit(0)	

cm_host = sys.argv[1]
cm_port = sys.argv[2]
cm_username = sys.argv[3]
cm_password = sys.argv[4]
#cm_cluster = sys.argv[4]


api = ApiResource(cm_host, cm_port, cm_username, cm_password)
successMark=0
try:
        for c in api.get_all_clusters():
                print c.name  
                cs=c.stop()
                print "stoppping"
                for i in xrange(50):
                        time.sleep(15)
                        for s in c.get_all_services():
                                if not s.serviceState=="STOPPED":
                                        successMark=0
                                        break
                                successMark=1;
                        if successMark==1:
                                print "all services in", c.name, "stopped"
                                break
                if successMark==0:
                        print "Ops, plz check ur cluster"

except Exception as msg:
        print "Manager server no respond: ",msg                                              


