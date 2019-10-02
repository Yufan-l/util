#!/bin/bash

/etc/init.d/impala-state-store stop
/etc/init.d/impala-catalog stop
/etc/init.d/impala-server stop
/etc/init.d/kudu-tserver stop
/etc/init.d/kudu-master stop
/etc/init.d/hadoop-hdfs-datanode stop
/etc/init.d/hadoop-hdfs-namenode stop
/etc/init.d/hive-metastore stop
