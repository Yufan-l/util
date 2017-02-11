#!/bin/bash
echo "running create-topics.sh"

if [[ -z "$START_TIMEOUT" ]]; then
    START_TIMEOUT=600
fi

start_timeout_exceeded=false
count=0
step=10
while netstat -lnt | awk '$4 ~ /:'9092'$/ {exit 1}'; do
    echo "waiting for kafka to be ready"
    sleep $step;
    count=$(expr $count + $step)
    if [ $count -gt $START_TIMEOUT ]; then
        start_timeout_exceeded=true
        break
    fi
done

if $start_timeout_exceeded; then
    echo "Not able to auto-create topic (waited for $START_TIMEOUT sec)"
    exit 1
fi

if [[ -n $KAFKA_CREATE_TOPICS ]]; then
    IFS=','; for topicToCreate in $KAFKA_CREATE_TOPICS; do
        echo "creating topics: $topicToCreate" 
        IFS=':' read -a topicConfig <<< "$topicToCreate"
        $KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper  localhost:2181 --replication-factor ${topicConfig[1]} --partition ${topicConfig[2]} --topic "${topicConfig[0]}"
    done
fi