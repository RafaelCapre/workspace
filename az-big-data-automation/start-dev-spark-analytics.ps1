#0. Sign in
$azureCredential = Get-AutomationPSCredential -Name 'azureautomation'
$azureCredential
Login-AzureRmAccount -Credential $azureCredential

#1. Select the subscription to use
$subscriptionID = Get-AutomationVariable -Name 'subscription-id'
Select-AzureRmSubscription -SubscriptionId $subscriptionID
Write-Output "Subscription: " $subscriptionID 

#2. Cluster Variables
$resourceGroupName = "DEVAnalytics"
$storageAccountName = "analyticsdevstorage"
$containerName = "devsparkanalytics"
$storageAccountKey = Get-AutomationVariable -Name 'analyticsdevstoragekey'
$clusterName = $containerName 
$clusterCredential = Get-AutomationPSCredential -Name 'cred-dev-spark-analytics-admin'
$sshCredential = Get-AutomationPSCredential -Name 'cred-dev-spark-analytics-sshuser'
$clusterType = "Spark"
$hdpversion = "3.6"
$clusterOS = "Linux"
$clusterNodes = 4 
$clusterNodeSize = "Standard_D12"
$clusterHeadSize = "Standard_D12"
$location = Get-AutomationVariable -Name 'Location_BR'
$VirtualNetworkId = "/subscriptions/82699d66-399b-4736-bc94-e0ccdc71a2d4/resourceGroups/RedeNaturaGeral/providers/Microsoft.Network/virtualNetworks/RedeNaturaAzure-SP"
$SubnetName= "/subscriptions/82699d66-399b-4736-bc94-e0ccdc71a2d4/resourceGroups/RedeNaturaGeral/providers/Microsoft.Network/virtualNetworks/RedeNaturaAzure-SP/subnets/SUBNETNATDEV-AZ1-Private"
$adminsql = Get-AutomationPSCredential -Name 'cred-dev-sqlmetadata-adminsql'

#3. Database Metastore
Write-Output "Definindo Hive Metastore"
$dbconfig = $clusterName 
$sqlAzureServerName = "hivemetadatahdidevserver.database.windows.net" 
$DatabaseName = "HiveMetadadaDevSpark" 
$DBCredential = Get-AutomationPSCredential -Name 'cred-dev-sqlmetadata-adminsql'
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
$ENV = "dev"
$CLUSTER_NAME = $containerName 
$CLUSTER_USER = $clusterCredential.UserName
    $SecurePassword = $clusterCredential.Password 
    $BSTR =  [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$CLUSTER_PASS = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
$CLUSTER_CREDENTIAL_PASS = Get-AutomationVariable -Name 'oracle-prd-userdataleke-pwd'

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
    -Parameters " "`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_modules.sh
Write-Output "============================================================"

Write-Output "ActionScript: Add Dynatrace"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add dynatrace" `
    -NodeTypes "HeadNode" `
    -Parameters " "`
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
    -Parameters "wasb://startup@analyticsdevstorage.blob.core.windows.net/action-script/yarn_capacity_caa.json $CLUSTER_NAME $CLUSTER_PASS"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/yarn_capacity_scheduler.sh `
    -debug
Write-Output "============================================================"


Write-Output "ActionScript: Limpa arquivos obsoletos"  
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "add cleanup" `
    -NodeTypes "HeadNode" `
    -Parameters " "`
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

<#
Write-Output "ActionScript: Restart YARN"
Submit-AzureRmHDInsightScriptAction `
    -ClusterName $clusterName `
    -Name "restart cluster" `
    -NodeTypes "HeadNode" `
    -Parameters "$CLUSTER_NAME $CLUSTER_USER $CLUSTER_PASS"`
    -ResourceGroupName "$resourceGroupName" `
    -Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/restart_cluster.sh
Write-Output "============================================================"

#>