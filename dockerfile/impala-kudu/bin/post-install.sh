#!/bin/bash

/bin/stop_all.sh
 
sudo -u postgres pg_ctl initdb -D /var/lib/pgsql/data


\cp /var/lib/pgsql/pg_hba.conf /var/lib/pgsql/data/

sudo -u postgres pg_ctl start -D /var/lib/pgsql/data -l /var/lib/pgsql/logfile -m smart

/bin/wait-for-it.sh localhost:5432 -t 10
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n----------------------------------------"
    echo -e "    postgres not ready! Exiting..."
    echo -e "----------------------------------------"
    exit $rc
fi

sudo -u postgres psql -c "CREATE user hive WITH PASSWORD 'hive';"
sudo -u postgres psql -c "CREATE database metastore;"
 
hadoop namenode -format
chmod -R 777 /var/lib/hadoop-hdfs/
sudo -u hive bash -c '/usr/lib/hive/bin/schematool -dbType postgres -initSchema'

rm -rf /var/lib/kudu/master/*
rm -rf /var/lib/kudu/tserver/*

sudo -u postgres pg_ctl stop -D /var/lib/pgsql/data -l /var/log/logfile
