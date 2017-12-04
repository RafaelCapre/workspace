#!/usr/bin/env bash
NOW=$(date +"%d/%m/%Y %H:%M") 
FUNCTION=$1
COMPONENT=$2
CLUSTER_NAME=$3
CLUSTER_CLUSTER_USER=$4
CLUSTER_CLUSTER_PASS=$5

#Example
#stop YARN cluster-hdi admin pa55w0rd

function start(){
    str=$(curl -u $CLUSTER_USER:$CLUSTER_PASS -i -H 'X-Requested-By: ambari' -X PUT -d \
      '{"RequestInfo": {"context" :"Start '"$COMPONENT"' via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' \
      http://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT)
    echo "sintax = " $str
    echo ${NOW} 
  }

function startWait(){
    str=$(curl -s -u $CLUSTER_USER:$CLUSTER_PASS -H 'X-Requested-By: ambari' -X PUT -d \
      '{"RequestInfo": {"context" :"Start '"$COMPONENT"' via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' \
      http://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT)
    echo "sintax = " $str
    echo ${NOW} 
    wait $COMPONENT "STARTED"
  }

function stop(){
    str=$(curl -u $CLUSTER_USER:$CLUSTER_PASS -i -H 'X-Requested-By: ambari' -X PUT -d \
      '{"RequestInfo": {"context" :"Stop '"$COMPONENT"' via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' \
      http://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT)
    echo "sintax = " $str
    echo ${NOW} 
  }

function stopWait(){
    curl -s -u $CLUSTER_USER:$CLUSTER_PASS -H 'X-Requested-By: ambari' -X PUT -d \
      '{"RequestInfo": {"context" :"Stop '"$COMPONENT"' via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' \
      http://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT
    wait $COMPONENT "INSTALLED"
  }

function maintOff(){
    curl -u $CLUSTER_USER:$CLUSTER_PASS -i -H 'X-Requested-By: ambari' -X PUT -d \
    '{"RequestInfo":{"context":"Turn Off Maintenance Mode"},"Body":{"ServiceInfo":{"maintenance_state":"OFF"}}}' \
    http://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT
  }

function maintOn(){
    curl -u $CLUSTER_USER:$CLUSTER_PASS -i -H 'X-Requested-By: ambari' -X PUT -d \
    '{"RequestInfo":{"context":"Turn Off Maintenance Mode"},"Body":{"ServiceInfo":{"maintenance_state":"ON"}}}' \
    http://${CLUSTER_NAME}.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT
  }

if [$FUNCTION == "delete"]
then 
  function delete(){
    curl -u $CLUSTER_USER:$CLUSTER_PASS -i -H 'X-Requested-By: ambari' -X DELETE http://$CLUSTER_NAME.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT
}

if [$FUNCTION == "wait"]
then 
  function wait(){
    finished=0
    while [ $finished -ne 1 ]
    do
      str=$(curl -s -u $CLUSTER_USER:$CLUSTER_PASS http://{$CLUSTER_NAME}.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT)
      if [[ $str == *"$COMPONENT"* ]] || [[ $str == *"Service not found"* ]] 
      then
        finished=1
      fi
      sleep 3
    done
  }

if [$FUNCTION == "check"]
then 
  function check() {
    str=$(curl -s -u $CLUSTER_USER:$CLUSTER_PASS http://{$CLUSTER_NAME}.azurehdinsight.net/api/v1/clusters/$CLUSTER/services/$COMPONENT)
    if [[ $str == *"$COMPONENT"* ]]
    then
      echo 1
    else
      echo 0
    fi
  }