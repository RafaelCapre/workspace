#!/usr/bin/env bash
#HeadNode Only
NOW=$(date +"%d/%m/%Y %H:%M")


#0. ENV
BLOB_NAME=$1
BLOB_KEY=$2
BLOB_CONTAINER=$3
CLUSTER_NAME=$4
CLUSTER_USER=$5
CLUSTER_PASS=$6
CLUSTER_CREDENTIALS_PASS=$7
CLUSTER_YARN_CONFIG_PATH=$8

echo "----------------------------------------------------" >> /home/sshuser/startup/start-log.out
echo "PARAMETERS:" ${NOW} >> /home/sshuser/startup/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/startup/start-log.out
echo "BLOB NAME:" ${BLOB_NAME} >> /home/sshuser/startup/start-log.out
echo "BLOB KEY:" ${BLOB_KEY}  >> /home/sshuser/startup/start-log.out
echo "BLOB CONTAINER:" ${BLOB_CONTAINER} >> /home/sshuser/startup/start-log.out
echo "CLUSTER NAME:" ${CLUSTER_NAME} >> /home/sshuser/startup/start-log.out
echo "CLUSTER USER:" ${CLUSTER_USER} >> /home/sshuser/startup/start-log.out
echo "CLUSTER PASS:" ${CLUSTER_PASS} >> /home/sshuser/startup/start-log.out
echo "CLUSTER CREDENTIALS PASS:" ${CLUSTER_CREDENTIALS_PASS} >> /home/sshuser/startup/start-log.out
echo "CLUSTER YARN CONFIG:" ${CLUSTER_YARN_CONFIG_PATH} >> /home/sshuser/startup/start-log.out
echo "OK:" ${NOW} >> /home/sshuser/startup/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/startup/start-log.out