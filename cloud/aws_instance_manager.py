#pip install boto or sudo apt-get install python-boto
#update credential in /etc/boto.cfg or ~/.boto:
#[Credentials]
#aws_access_key_id = <your_access_key_here>
#aws_secret_access_key = <your_secret_key_here>
#Region is something like us-west-1, us-west-2

import sys
import boto.ec2

if len(sys.argv)<3:
	print 'wrong argument'
	sys.exit(0)

task = sys.argv[1]
region = sys.argv[2]
instances = sys.argv[3:]

conn = boto.ec2.connect_to_region(region)


if task == 'stop':
	conn.stop_instances(instances,False)

elif task == 'start':
	conn.start_instances(instances)

else:
	print 'wrong task name'
	sys.exit(0)
