#!/usr/bin/env bash
#HeadNode Only
NOW=$(date +"%d/%m/%Y %H:%M")

echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "CLEAN FILES:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
sudo rm /home/sshuser/add-storage-account-v01.sh
sudo rm /home/sshuser/scripts.zip
sudo rm -r /home/sshuser/api

echo "OK:" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out