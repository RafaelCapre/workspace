#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
echo "----------------------------------------------------" >> sudo /home/sshuser/start-log.out
echo "DYNATRACE SAAS" ${NOW} >> sudo /home/sshuser/start-log.out
echo "----------------------------------------------------" >> sudo /home/sshuser/start-log.out
wget -O dynatrace.sh https://kfl34152.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?Api-Token=TXXkG4g6RyipFRwmkK_lR&arch=x86
sudo /bin/sh dynatrace.sh
echo "OK" ${NOW} >> sudo /home/sshuser/start-log.out
echo "----------------------------------------------------" >> sudo /home/sshuser/start-log.out
