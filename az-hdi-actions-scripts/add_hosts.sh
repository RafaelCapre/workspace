#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "ETC HOSTS" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
sudo echo "172.26.14.57 dm01pr-scan.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.56 dm01pr-scan.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.55 dm01pr-scan.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.231 dm02-scan.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.230 dm02-scan.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.229 dm02-scan.natura.com.br" >> /etc/hosts
sudo echo "172.27.57.18 drp01-scan.natura.com.br" >> /etc/hosts
sudo echo "172.27.57.17 drp01-scan.natura.com.br" >> /etc/hosts
sudo echo "172.27.57.16 drp01-scan.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.57 vipo03dwsvcprd.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.56 vipo03dwsvcprd.natura.com.br" >> /etc/hosts
sudo echo "172.26.14.55 vipo03dwsvcprd.natura.com.br" >> /etc/hosts
echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out