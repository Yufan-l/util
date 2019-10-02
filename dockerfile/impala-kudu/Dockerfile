FROM centos:7

ADD cdh.repo /etc/yum.repos.d/

RUN yum -y install initscripts 


RUN yum update -y; \
    yum install -y telnet vim python-setuptools sudo; \
    easy_install supervisor

RUN yum install -y kudu-master kudu-tserver
RUN yum install -y impala-catalog impala-state-store impala-server impala-shell
RUN yum install -y hadoop-hdfs-datanode hadoop-hdfs-namenode
RUN yum install -y telnet
RUN yum install -y hive-metastore schematool
RUN yum install -y postgresql postgresql-server postgresql-jdbc

ADD etc/default/* /etc/default/
ADD etc/hadoop/* /etc/hadoop/conf/
ADD etc/impala/*  /etc/impala/conf/
ADD etc/hive/* /etc//hive/conf/
ADD etc/kudu/* /etc/kudu/conf/
ADD bin/* /bin/




RUN groupadd supergroup; \ 
    usermod -a -G supergroup impala; \
    usermod -a -G hdfs impala; \
    usermod -a -G supergroup hive; \
    usermod -a -G hdfs hive

RUN cp /usr/share/java/postgresql-jdbc.jar /usr/lib/hive/lib

ADD etc/pg_hba.conf /var/lib/pgsql/
ADD etc/supervisord.conf /etc/


RUN bin/post-install.sh


# Impala Ports
EXPOSE 21000 21050 22000 23000 24000 25010 26000 28000

##########################
# Kudu Ports
##########################
EXPOSE 8050 7050 8051 7051

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]