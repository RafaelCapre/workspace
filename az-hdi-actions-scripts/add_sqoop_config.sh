#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M")
BLOB_NAME=$1
ENV=$2
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "SQOOP CONFIG " ${NOW}  >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
cd /usr/hdp/current/sqoop-client/lib
sudo wget "https://"${BLOB_NAME}".blob.core.windows.net/"${ENV}"/util/sqoop/jars/ojdbc6.jar"
sudo wget "https://"${BLOB_NAME}".blob.core.windows.net/"${ENV}"/util/sqoop/jars/mysql-connector-java-5.1.42-bin.jar" 
cd /usr/hdp/current/sqoop-client/conf
sudo sh -c 'hdfs dfs -cat "wasb://'${ENV}@${BLOB_NAME}'.blob.core.windows.net/util/sqoop/sqoop-site.xml" > /usr/hdp/current/sqoop-client/conf/sqoop-site.xml'
#sudo rm -r /usr/hdp/current/sqoop-client/conf/sqoop-site.xml 
#sudo wget "https://"${BLOB_NAME}".blob.core.windows.net/"${ENV}"/util/sqoop/sqoop-site.xml" 
sudo chown sqoop:hadoop /usr/hdp/current/sqoop-client/conf/sqoop-site.xml
sudo chown sshuser:sshuser /home/sshuser/.sqoop
echo "OK" ${NOW} >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out