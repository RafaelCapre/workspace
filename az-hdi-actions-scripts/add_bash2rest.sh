#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
BLOB_NAME=$1
ENV=$2
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo " REST API CONFIG" ${NOW}  >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
wget "https://"${BLOB_NAME}".blob.core.windows.net/"${ENV}"/util/scripts/scripts.zip" -P /home/sshuser/
unzip /home/sshuser/scripts.zip -d /home/sshuser/
sudo chown -R sshuser:sshuser /home/sshuser/scripts/
sudo chmod 777 -R /home/sshuser/scripts/
dos2unix /home/sshuser/scripts/shell-scripts/*
sudo -u sshuser nohup python /home/sshuser/scripts/bash2rest/bash2restblue.py > /home/sshuser/scripts/bash2rest/nohup.out &
echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out