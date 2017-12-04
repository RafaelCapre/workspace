#!/usr/bin/env bash
#HeadNode Only
NOW=$(date +"%d/%m/%Y %H:%M")


BLOB_NAME=$1
ENV=$2
CLUSTER_NAME=$3

#6. Configuracao de cron (bkp bash2rest logs)
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "CRON CONFIG:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
crontab -l | { cat; echo "*/5 * * * * hdfs dfs -mkdir -p wasb://"${ENV}"@"${BLOB_NAME}".blob.core.windows.net/zlog/bash2rest/"${CLUSTER_NAME}"/ && hdfs dfs -put -f /home/sshuser/scripts/bash2rest/logs/* wasb://"${ENV}"@"${BLOB_NAME}".blob.core.windows.net/zlog/bash2rest/"${CLUSTER_NAME}"/"; } | crontab -

echo "OK:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out