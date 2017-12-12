#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "PIP / APT-GET " ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
sudo apt-get --assume-yes install jq 
sudo apt-get --assume-yes install sed
sudo apt-get --assume-yes install tree
sudo apt-get --assume-yes install zip
sudo apt-get --assume-yes install dos2unix
sudo pip install setuptools
sudo pip install flask
sudo pip install pystache
sudo pip install azure-storage==0.20.0

	
echo "OK " ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
