#0. Sign in
$azureCredential = Get-AutomationPSCredential -Name 'azureautomation'
$azureCredential
Login-AzureRmAccount -Credential $azureCredential

#1. Select the subscription to use
$subscriptionID = Get-AutomationVariable -Name 'subscription-id'
Select-AzureRmSubscription -SubscriptionId $subscriptionID
Write-Output "Subscription: " $subscriptionID 

#2. Cluster Variables
$resourceGroupName = "PRD-Dir-BI-Analytics"
$storageAccountName = "analyticsprdstorage"
$containerName = "prd01ingestion-analytics"
$clusterName = $containerName 
$clusterCredential = Get-AutomationPSCredential -Name 'cred-prd-spark-analytics-admin'
$sshCredential = Get-AutomationPSCredential -Name 'cred-prd-spark-analytics-sshuser'
$clusterType = "Spark"
$hdpversion = "3.6"
$clusterOS = "Linux"
$clusterNodes = 4 
$clusterNodeSize = "Standard_D12"
$clusterHeadSize = "Standard_D12"
$location = Get-AutomationVariable -Name 'Location_BR'

#2.2. Dynamic Variables
$clusterName = $containerName
$clusterCredential  = Get-AutomationPSCredential -Name 'cred-prd-spark-ingestion01-admin'
$sshCredential      = Get-AutomationPSCredential -Name 'cred-prd-spark-ingestion01-sshuser' 
$net                = Get-AutomationVariable -Name 'Net'
$location           = Get-AutomationVariable -Name 'Location_BR'
$VirtualNetworkId   = "/subscriptions/" + $subscriptionID + "/resourceGroups/RedeNaturaGeral/providers/Microsoft.Network/virtualNetworks/" + $net
$SubnetName         = $VirtualNetworkId + "/subnets/SUBNETNATPRD-AZ1-Private"

#2.3. Dynamic StorageKey
$primaryStorageAcctName = $storageAccountName
$primaryStorageResourceGroupName = $resourceGroupName
$storageAccountKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $primaryStorageResourceGroupName -Name $primaryStorageAcctName).Value[0]

#3. Database Metastore
Write-Output "Definindo Hive Metastore"
$dbconfig = $clusterName 
$sqlAzureServerName = "hivemetadaprdanalyticsserver.database.windows.net" 
$DatabaseName = "HiveMetadadaPRD01IngestionAnalytics" 
$DBCredential = Get-AutomationPSCredential -Name 'cred-prd-spark-exploration01-adminsql'
$MetastoreType = "HiveMetaStore"


#4. Deploy
Write-Output "Executando:" 
New-AzureRmHDInsightClusterConfig -ClusterType $clusterType `
    | Add-AzureRmHDInsightMetastore -Credential $DBCredential `
        -Database $DatabaseName `
        -MetaStoreType $MetastoreType `
        -SqlAzureServerName $sqlAzureServerName `
    | New-AzureRmHDInsightCluster -OSType $clusterOS `
        -ClusterSizeInNodes $clusterNodes `
        -ResourceGroupName $resourceGroupName `
        -ClusterName $clusterName `
        -HeadNodeSize $clusterHeadSize `
        -WorkerNodeSize $clusterNodeSize `
        -HttpCredential $clusterCredential `
        -SshCredential $sshCredential `
        -Location $location `
        -Version $hdpversion `
        -VirtualNetworkId $VirtualNetworkId `
        -SubnetName $SubnetName `
        -DefaultStorageAccountName "$storageAccountName.blob.core.windows.net" `
        -DefaultStorageAccountKey $storageAccountKey `
        -DefaultStorageContainer $containerName 

Write-Output "Cluster no ar" 

#5 ActionScripts
#5.1 Constantes:
$BLOB_NAME = "naturaanalytics"
$BLOB_KEY = Get-AutomationVariable -Name 'naturaanalyticskey'
$ENV = "prd"
$CLUSTER_NAME = $containerName 
$CLUSTER_USER = $clusterCredential.UserName
    $SecurePassword = $clusterCredential.Password 
    $BSTR =  [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$CLUSTER_PASS = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
#$CLUSTER_CREDENTIAL_PASS = Get-AutomationVariable -Name 'oracle-prd-userdataleke-pwd'

Write-Output "ActionScript: add_hosts.sh (HeadNodea)"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add hosts headnode" `
    -NodeTypes "HeadNode" `
    -Parameters " "`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_hosts.sh 
Write-Output "============================================================"

Write-Output "ActionScript: add_hosts.sh (WorkerNode)"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add hosts workernode" `
    -NodeTypes "WorkerNode" `
    -Parameters " "`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_hosts.sh 
Write-Output "============================================================"

Write-Output "ActionScript: Add Modules"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add modules" `
    -NodeTypes "HeadNode" `
    -Parameters " " `
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_modules.sh
Write-Output "============================================================"

Write-Output "ActionScript: Add Dynatrace"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add dynatrace" `
    -NodeTypes "HeadNode" `
    -Parameters " " `
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_dynatrace.sh
Write-Output "============================================================"

Write-Output "ActionScript: Add Sqoop Configuration"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add sqoop config debug" `
    -NodeTypes "HeadNode" `
    -Parameters "$BLOB_NAME $ENV"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_sqoop_config.sh `
    -debug
Write-Output "============================================================"

Write-Output "ActionScript: Add Storage Account"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add naturaanalytics" `
    -NodeTypes "HeadNode" `
    -Parameters "$BLOB_NAME $BLOB_KEY"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://hdiconfigactions.blob.core.windows.net/linuxaddstorageaccountv01/add-storage-account-v01.sh 
Write-Output "============================================================"

Write-Output "ActionScript: Configura Bash2Rest" 
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add bash2rest" `
    -NodeTypes "HeadNode" `
    -Parameters "$BLOB_NAME $ENV $CLUSTER_NAME"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_bash2rest.sh
Write-Output "============================================================"

Write-Output "ActionScript: Configura crontab Bash2Rest"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add bash2rest crontab" `
    -NodeTypes "HeadNode" `
    -Parameters "$BLOB_NAME $ENV $CLUSTER_NAME"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_bash2rest_crontab.sh
Write-Output "============================================================"

Write-Output "ActionScript: Add YARN Config CAA"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add yarn config caa debug" `
    -NodeTypes "HeadNode" `
    -Parameters "wasb://startup@$storageAccountName.blob.core.windows.net/action-script/yarn_capacity_caa.json $CLUSTER_NAME $CLUSTER_PASS"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/yarn_capacity_scheduler.sh `
    -debug
Write-Output "============================================================"


Write-Output "ActionScript: Limpa arquivos obsoletos"  
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add cleanup" `
    -NodeTypes "HeadNode" `
    -Parameters " " `
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_cleanup.sh
Write-Output "============================================================"

Write-Output "ActionScript: Configura Hadoop Credentials"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add hdfs credential" `
    -NodeTypes "HeadNode" `
    -Parameters "$CLUSTER_NAME $CLUSTER_CREDENTIALS_PASS $BLOB_CONTAINER"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_hdfs_credential.sh
Write-Output "============================================================"