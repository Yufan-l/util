#!/bin/bash
zk=$1
ip=$2

if [ -z "$zk" ];then
 echo "please provide zk info"
 exit
fi

if [ -z "$ip" ];then
 echo "please provide slave ip"
 exit
fi


sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -y update

sudo apt-get install mesos

sudo service zookeeper stop
sudo sh -c "echo manual > /etc/init/zookeeper.override"

echo $zk >  /etc/mesos/zk
echo 'docker,mesos' > /etc/mesos-slave/containerizers
echo $ip > /etc/mesos-slave/hostname
echo $ip > /etc/mesos-slave/ip

sudo service mesos-master stop
sudo sh -c "echo manual > /etc/init/mesos-master.override"

sudo service mesos-slave restart
