#!/usr/bin/env bash
#HeadNode Only
NOW=$(date +"%d/%m/%Y %H:%M")


CLUSTER_NAME=$1
CLUSTER_CREDENTIALS_PASS=$2
BLOB_CONTAINER=$3



echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "HADOOP CREDENTIALS CONFIG:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

echo "hadoop credential create sqoop_${CLUSTER_NAME}_ps -value ${CLUSTER_CREDENTIALS_PASS} -provider jceks://wasb/${BLOB_CONTAINER}/util/sqoop/${CLUSTER_NAME}/sqoop_${CLUSTER_NAME}_ps.jceks"
hadoop credential create sqoop_${CLUSTER_NAME}_ps -value ${CLUSTER_CREDENTIALS_PASS} -provider jceks://wasb/${BLOB_CONTAINER}/util/sqoop/${CLUSTER_NAME}/sqoop_${CLUSTER_NAME}_ps.jceks

echo "OK:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out