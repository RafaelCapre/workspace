#!/bin/sh
#title           :startup-prd-ingestion-kafka.sh
#description     :This script must run to setup Natura configurations and customizations of HDInsight Cluster PRD-Ingestion-Kafka
#author		 	 :b95142
#date            :2017-08-29
#version         :1
#usage		     :startup-prd-ingestion-kafka.sh
#notes           :Aplica-se somente em headnodes.
#bash_version    :4.3.11(1)-release
#URI			 :https://hdidevstorage.blob.core.windows.net/startup/startup-dev-kakfa.sh
#==============================================================================


#0.ENV

	CLUSTER_NAME=$1
	CLUSTER_USER=$2
	CLUSTER_PASS=$3
	#BLOB_NAME=$4
	#BLOB_KEY=$5
	
	#0.1 Constantes:
	BLOB_CONTAINER='startup'
	ZOO=$(curl -u $CLUSTER_USER:$CLUSTER_PASS -X GET "https://"$CLUSTER_NAME".azurehdinsight.net/api/v1/clusters/"$CLUSTER_NAME"/services/ZOOKEEPER/components/ZOOKEEPER_SERVER" | jq .host_components[].HostRoles.host_name | sed 's/"//g' | sed -z "s/\n/:2181,/g")
	KAFKA_HOME=/usr/hdp/current/kafka-broker/
	

sudo chmod 777 /home/sshuser/start-log.out
	
echo "START: " `date` >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "0. PARAMETERS" >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

	echo "0.1. CLUSTER NAME:" ${CLUSTER_NAME} >> start-log.out
	echo "0.2. CLUSTER USER:" $CLUSTER_USER >> start-log.out
	echo "0.3. CLUSTER PASS:" $CLUSTER_PASS >> start-log.out
	echo "0.4. ZOOKEEPER_QUROUM:" $ZOO >> start-log.out

echo "OK" >> start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

#1.Python/Shell
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "1. PIP / APT-GET" >> start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
	cd ~
	sudo apt-get --assume-yes install jq 
	sudo apt-get --assume-yes install sed
	sudo apt-get --assume-yes install tree
	sudo apt-get --assume-yes install zip
	sudo apt-get --assume-yes install dos2unix
	sudo pip install flask
	sudo pip install pystache
	sudo pip install azure-storage==0.20.0

echo "OK" >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out


#2. Monitoring Tool
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "2. MONITORING AGENT" >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
	cd ~
	mkdir /home/sshuser/oneagent
	cd /home/sshuser/oneagent
	sudo wget  -O Dynatrace-OneAgent-Linux-1.115.156.sh https://kfl34152.live.dynatrace.com/installer/agent/unix/latest/yjeVTtZsjT2oKXI8
	sudo wget https://ca.dynatrace.com/dt-root.cert.pem ; ( echo -e 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"\n\n----SIGNED-INSTALLER' ; cat Dynatrace-OneAgent-Linux-1.115.156.sh ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null
	sudo /bin/sh Dynatrace-OneAgent-Linux-1.115.156.sh APP_LOG_CONTENT_ACCESS=1  >> /home/sshuser/start-log.out

echo "OK" >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out


#3. Criação de Tópicos
echo "----------------------------------------------------" >> /home/sshuser/start-log.out
echo "2. TOPICS" >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

	#Para criação de um novo tópico, basta atualizar o arquivo: "https://hdidevstorage.blob.core.windows.net/startup/topicos.txt" em formato UNX no Azure Explorer.
	mkdir /home/sshuser/startup/
	cd /home/sshuser/startup/
	rm -rf topicos.txt
	sudo wget https://hdidevstorage.blob.core.windows.net/startup/topicos.txt >> /home/sshuser/start-log.out
	md5sum /home/sshuser/startup/topicos.txt
	
	array=( ${array[@]} `cat /home/sshuser/startup/topicos.txt` )
	for i in "${array[@]}"
			do
					$KAFKA_HOME/bin/kafka-topics.sh --zookeeper $ZOO --create --if-not-exists --topic $i  --partitions 2 --replication-factor 2 >> /home/sshuser/start-log.out
					echo "Topic: "$i "deployed or updated" >> /home/sshuser/start-log.out
					echo "Topic: "$i "deployed or updated"
			done
	
	sudo /usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $ZOO --list >> /home/sshuser/start-log.out
	sudo /usr/hdp/current/kafka-broker/bin/kafka-topics.sh --zookeeper $ZOO --list
	
	
echo "OK" >> /home/sshuser/start-log.out
echo "----------------------------------------------------" >> /home/sshuser/start-log.out

echo "DONE: " `date` >> /home/sshuser/start-log.out