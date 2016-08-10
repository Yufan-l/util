#!/bin/bash
zk=$1
ip=$2



if [ -z "$zk" ];then
 echo "please provide zk ip"
 exit
fi

if [ -z "$ip" ];then
 echo "please provide mesos ip"
 exit
fi

yum install java-1.8.0-openjdk

sudo rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm

sudo yum -y install mesos marathon

sudo yum -y install mesosphere-zookeeper

echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
 
echo zk://$zk:2181/mesos > /etc/mesos/zk
echo $ip > /etc/mesos-master/hostname
echo $ip > /etc/mesos-master/ip
echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo $ip > /etc/mesos-slave/hostname
echo $ip > /etc/mesos-slave/ip
echo '10mins' > /etc/mesos-slave/executor_registration_timeout


sudo service mesos-master restart
sudo service mesos-slave restart
