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

sudo apt-add-repository -y ppa:openjdk-r/ppa
sudo apt-get -y update
sudo apt-get -y install openjdk-8-jdk

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
CODENAME=$(lsb_release -cs)

echo "deb http://repos.mesosphere.com/${DISTRO} ${CODENAME} main" | sudo tee /etc/apt/sources.list.d/mesosphere.list
sudo apt-get -y update

sudo apt-get -y install mesos marathon

echo $zk >  /etc/mesos/zk
echo $ip > /etc/mesos-master/hostname
echo $ip > /etc/mesos-master/ip

sudo service mesos-slave stop
sudo sh -c "echo manual > /etc/init/mesos-slave.override"

sudo service mesos-master restart
sudo service marathon restart
