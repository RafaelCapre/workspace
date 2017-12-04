#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
CLUSTER_NAME=$1
CLUSTER_USER=$2
CLUSTER_PASS=$3

echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "YARN CONFIG C.A.A." ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

rm-r add_yarn_conf_caa.sh
wget https://analyticsdevstorage.blob.core.windows.net/startup/action-script/add_yarn_conf_caa.sh
fromdos add_yarn_conf_caa.sh
/bin/sh add_yarn_conf_caa.sh $CLUSTER_NAME $CLUSTER_USER $CLUSTER_PASS
sleep 200

echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
