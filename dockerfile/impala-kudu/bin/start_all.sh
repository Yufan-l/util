#!/bin/bash
 
sudo -u postgres pg_ctl start -D /var/lib/pgsql/data -l /var/lib/pgsql/logfile -m smart

/bin/wait-for-it.sh localhost:5432 -t 10
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n----------------------------------------"
    echo -e "    postgres not ready! Exiting..."
    echo -e "----------------------------------------"
    exit $rc
fi

/etc/init.d/hive-metastore start
/bin/wait-for-it.sh localhost:9083 -t 30
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n----------------------------------------"
    echo -e "    Hive not ready! Exiting..."
    echo -e "----------------------------------------"
    exit $rc
fi

/etc/init.d/hadoop-hdfs-datanode start
/etc/init.d/hadoop-hdfs-namenode start
/bin/wait-for-it.sh localhost:8020 -t 60
/bin/wait-for-it.sh localhost:9867 -t 30
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n----------------------------------------"
    echo -e "    HDFS not ready! Exiting..."
    echo -e "----------------------------------------"
    exit $rc
fi

/etc/init.d/kudu-tserver start
/etc/init.d/kudu-master start
/bin/wait-for-it.sh localhost:7050 -t 30
/bin/wait-for-it.sh localhost:7051 -t 30
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n----------------------------------------"
    echo -e "    Kudu  not ready! Exiting..."
    echo -e "----------------------------------------"
    exit $rc
fi

/etc/init.d/impala-state-store start
/etc/init.d/impala-catalog start
/etc/init.d/impala-server start
/bin/wait-for-it.sh localhost:21050 -t 30
/bin/wait-for-it.sh localhost:25000 -t 30
/bin/wait-for-it.sh localhost:25010 -t 30
/bin/wait-for-it.sh localhost:25020 -t 30
 rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n----------------------------------------"
    echo -e "    Impala not ready! Exiting..."
    echo -e "----------------------------------------"
    exit $rc
fi
 
 
 
