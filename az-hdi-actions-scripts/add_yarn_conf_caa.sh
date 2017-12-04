#!/usr/bin/env bash

CLUSTER_NAME=$1
CLUSTER_USER=$2
CLUSTER_PASS=$3

VERSION=$(date +"%d-%m-%Y_%H-%M")
NOW=$(date +"%d/%m/%Y %H:%M")

echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "YARN CONFIG CAA" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

curl -u ${CLUSTER_USER}:${CLUSTER_PASS} -H "X-Requested-By:ambari" -iX PUT -d '{"Clusters": { "desired_config": [{ "type": "capacity-scheduler","tag": "${VERSION}","service_config_version_note": "CAA","properties":{"yarn.scheduler.capacity.root.caa.capacity":"89","yarn.scheduler.capacity.root.thriftsvr.state":"RUNNING","yarn.scheduler.capacity.root.thriftsvr.capacity":"10","yarn.scheduler.capacity.root.default.capacity":"1","yarn.scheduler.capacity.root.default.maximum-capacity":"1","yarn.scheduler.capacity.root.default.user-limit-factor":"10","yarn.scheduler.capacity.root.default.priority":"0","yarn.scheduler.capacity.root.default.state":"RUNNING","yarn.scheduler.capacity.root.thriftsvr.maximum-capacity":"10","yarn.scheduler.capacity.root.accessible-node-labels":"*","yarn.scheduler.capacity.root.caa.maximum-capacity":"89","yarn.scheduler.capacity.maximum-am-resource-percent":"0.33","yarn.scheduler.capacity.root.caa.user-limit-factor":"10","yarn.scheduler.capacity.root.thriftsvr.priority":"0","yarn.scheduler.capacity.root.acl_administer_queue":"*","yarn.scheduler.capacity.root.caa.priority":"0","yarn.scheduler.capacity.resource-calculator":"org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator","yarn.scheduler.capacity.root.thriftsvr.user-limit-factor":"10","yarn.scheduler.capacity.root.caa.state":"RUNNING","yarn.scheduler.capacity.root.priority":"0","yarn.scheduler.capacity.root.queues":"caa,default,thriftsvr","yarn.scheduler.capacity.root.capacity":"100","yarn.scheduler.capacity.node-locality-delay":"0","yarn.scheduler.capacity.root.caa.acl_submit_applications":"*","yarn.scheduler.capacity.maximum-applications":"10000", "yarn.scheduler.capacity.queue-mappings-override.enable":"false"} } ] } }' "https://"${CLUSTER_NAME}".azurehdinsight.net/api/v1/clusters/"${CLUSTER_NAME}

echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
