#!/usr/bin/env bash
home=/home/sshuser
Configurations=$1
ClusterName=$2
CLUSTER_PASS=$3
HDInsightRestUri=https://$ClusterName.azurehdinsight.net/api/v1/clusters/$ClusterName
VERSION=$(date +"%d%m%Y%H%M")
NOW=$(date +"%d/%m/%Y %H:%M")
ConfLocal=$home/ConfLocal.json
PropertiesFileLocal=$home/capacity_scheduler_config.properties

#wasb://startup@analyticsdevstorage.blob.core.windows.net/startup/action-script/yarn_capacity_caa.json
#https://analyticsdevstorage.blob.core.windows.net/startup/action-script/yarn_capacity_caa.json


hdfs dfs -cat $Configurations > $ConfLocal
sed -i "s/version_number/$VERSION/g" $ConfLocal

YarnStopRequest='{"RequestInfo": {"context": "Stop  YARN by custom shell"}, "ServiceInfo": {"state": "INSTALLED"}}'
YarnStartequest='{"RequestInfo": {"context": "Start YARN by custom shell"}, "ServiceInfo": {"state": "STARTED"}}'


echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "YARN CONFIG CAA" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

curl -u admin:$CLUSTER_PASS -H "X-Requested-By: ambari" -X PUT --data-binary "@$ConfLocal" "$HDInsightRestUri"

sleep 15
curl -u admin:$CLUSTER_PASS -H "X-Requested-By: ambari" -i -X PUT -d "$YarnStopRequest" $HDInsightRestUri/services/YARN

sleep 30
curl -u admin:$CLUSTER_PASS -H "X-Requested-By: ambari" -i -X PUT -d "$YarnStartequest" $HDInsightRestUri/services/YARN


echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

rm -r $ConfLocal