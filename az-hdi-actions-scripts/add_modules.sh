#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "PIP / APT-GET " ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
sudo apt-get install tree
sudo apt-get install zip
sudo apt-get install dos2unix
sudo pip install setuptools
sudo pip install flask
sudo pip install pystache
echo "OK " ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
