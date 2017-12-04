#!/usr/bin/env bash
home=/home/sshuser
ClusterName=$1
CLUSTER_PASS=$2

HDInsightRestUri=https://$ClusterName.azurehdinsight.net/api/v1/clusters/$ClusterName
VERSION=$(date +"%d%m%Y%H%M")
NOW=$(date +"%d/%m/%Y %H:%M")
ConfLocal=$home/ConfLocal.json
PropertiesFileLocal=$home/capacity_scheduler_config.properties


YarnStopRequest='{"RequestInfo": {"context": "Stop  YARN by custom shell"}, "ServiceInfo": {"state": "INSTALLED"}}'
YarnStartequest='{"RequestInfo": {"context": "Start YARN by custom shell"}, "ServiceInfo": {"state": "STARTED"}}'


echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "YARN CONFIG CAA" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out


curl -u admin:$CLUSTER_PASS -H "X-Requested-By: ambari" -i -X PUT -d "$YarnStartequest" $HDInsightRestUri/services/YARN


echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

