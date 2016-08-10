#!/bin/bash
zk=$1
ip=$2

if [ -z "$zk" ];then
 echo "please provide zk info"
 exit
fi

if [ -z "$ip" ];then
 echo "please provide ip"
 exit
fi

dpkg -i docker-engine_1.11.2-0~trusty_amd64.deb
dpkg -i liblog4j1.2-java_1.2.17-4ubuntu3_all.deb
dpkg -i libnetty-java_1%3a3.2.6.Final-2_all.deb
dpkg -i libslf4j-java_1.7.5-2_all.deb
dpkg -i libjline-java_1.0-2_all.deb 
dpkg -i libxml-commons-external-java_1.4.01-2build1_all.deb 
dpkg -i libxml-commons-resolver1.1-java_1.2-7build1_all.deb 
dpkg -i libxerces2-java_2.11.0-7_all.deb 
dpkg -i libzookeeper-java_3.4.5+dfsg-1_all.deb
dpkg -i zookeeper_3.4.5+dfsg-1_all.deb
dpkg -i zookeeperd_3.4.5+dfsg-1_all.deb

dpkg -i libapr1_1.5.0-1_amd64.deb
dpkg -i libaprutil1_1.5.3-1_amd64.deb
dpkg -i libserf-1-1_1.3.3-1ubuntu0.1_amd64.deb
dpkg -i libsvn1_1.8.8-1ubuntu3.2_amd64.deb
dpkg -i mesos_0.28.2-2.0.27.ubuntu1404_amd64.deb

dpkg -i marathon_1.1.1-1.0.472.ubuntu1404_amd64.deb



echo zk://$zk:2181/mesos > /etc/mesos/zk
echo $ip > /etc/mesos-master/hostname
echo $ip > /etc/mesos-master/ip
echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo $ip > /etc/mesos-slave/hostname
echo $ip > /etc/mesos-slave/ip
echo '10mins' > /etc/mesos-slave/executor_registration_timeout


sudo service mesos-master restart
sudo service mesos-slave restart
sudo service marathon restart

