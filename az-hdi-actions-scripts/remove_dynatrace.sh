#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
echo "----------------------------------------------------" >> sudo /home/sshuser/start-log.out
echo "REMOVE DYNATRACE SAAS" ${NOW} >> sudo /home/sshuser/start-log.out
echo "----------------------------------------------------" >> sudo /home/sshuser/start-log.out
sudo /bin/sh /opt/dynatrace/oneagent/agent/uninstall.sh
echo "OK" ${NOW} >> sudo /home/sshuser/start-log.out
echo "----------------------------------------------------" >> sudo /home/sshuser/start-log.out
