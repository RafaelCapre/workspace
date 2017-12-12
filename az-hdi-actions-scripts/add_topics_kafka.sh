#!/usr/bin/env bash

#kafkadev O2JPIPYwMD79@

CLUSTER_NAME=$1
CLUSTER_PASS=$2
ZOO=$(curl -u admin:$CLUSTER_PASS -X GET "https://"$CLUSTER_NAME".azurehdinsight.net/api/v1/clusters/"$CLUSTER_NAME"/services/ZOOKEEPER/components/ZOOKEEPER_SERVER" | jq .host_components[].HostRoles.host_name | sed 's/"//g' | sed -z "s/\n/:2181,/g")
KAFKA_HOME=/usr/hdp/current/kafka-broker/bin/

#Para cria��o de um novo t�pico, basta atualizar o arquivo: "https://hdidevstorage.blob.core.windows.net/startup/topicos.txt" em formato UNX no Azure Explorer.
mkdir /home/sshuser/startup/
cd /home/sshuser/startup/
sudo rm -rf topicos.txt
sudo wget https://hdidevstorage.blob.core.windows.net/startup/topicos.txt 
md5sum /home/sshuser/startup/topicos.txt

echo $ZOO	
array=( ${array[@]} `cat /home/sshuser/startup/topicos.txt` )
for i in "${array[@]}"
	do
    	$KAFKA_HOME/kafka-topics.sh --zookeeper $ZOO --create --if-not-exists --topic $i  --partitions 2 --replication-factor 2 
	done

echo "*** Lista de Tópicos Criados ***"
sudo $KAFKA_HOME/kafka-topics.sh --zookeeper $ZOO --list 
echo " \n"

echo "DONE: " `date` 