#!/usr/bin/env bash
#HeadNode Only
NOW=$(date +"%d/%m/%Y %H:%M")
CLUSTER_USER=$1
CLUSTER_PASS=$2
CLUSTER_NAME=$3
BLOB_NAME=$4
BLOB_KEY=$5

#4. Storage Account
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "4. STORAGE ACCOUNT:" ${NOW}  >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

sudo python /var/lib/ambari-server/resources/scripts/configs.py \
-u ${CLUSTER_USER} \
-p ${CLUSTER_PASS} \
-l ${CLUSTER_NAME}'.azurehdinsight.net' \
-t '' \
-s "https" \
-n ${CLUSTER_NAME} \
-c 'core-site' \
-a 'set' \
-k 'fs.azure.account.key.'${BLOB_NAME}'.blob.core.windows.net' \
-v ${BLOB_KEY}

echo "OK:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out