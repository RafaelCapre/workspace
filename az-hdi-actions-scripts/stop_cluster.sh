#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M") 
CLUSTER_NAME=$1
CLUSTER_USER=$2
CLUSTER_PASS=$3
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "RESTART COMPONENTS:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
curl -i -u ${CLUSTER_USER}:${CLUSTER_PASS} -H "X-Requested-By: ambari" -X PUT  -d '{"RequestInfo":{"context":"_PARSE_.STOP.ALL_SERVICES","operation_level":{"level":"CLUSTER","cluster_name":"`${CLUSTERNAME}`"}},"Body":{"ServiceInfo":{"state":"INSTALLED"}}}' https://${CLUSTER_NAME}.azurehdinsight.net/api/v1/clusters/${CLUSTER_NAME}/services
sleep 120
echo "OK:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
