#0. Sign in
$azureCredential = Get-AutomationPSCredential -Name 'azureautomation' #Automation credential for Azure login
Login-AzureRmAccount -Credential $azureCredential

#1. Select the subscription to use
$subscriptionID = Get-AutomationVariable -Name 'subscription-id'
Select-AzureRmSubscription -SubscriptionId $subscriptionID


#2. Cluster Variables
$resourceGroupName = "DEV"
$storageAccountName = "hdidevstorage"
$containerName = "kafkadev"
$storageAccountKey = Get-AutomationVariable -Name 'hdidevstoragekeycb'
$clusterName = $containerName 
$clusterCredential = Get-AutomationPSCredential -Name 'cred-admin-kafkadev'
$sshCredential = Get-AutomationPSCredential -Name 'cred-sshuser-kafkadev'
$clusterType = "Kafka"
$hdpversion = "3.6"
$clusterOS = "Linux"
$clusterNodes = 3
$clusterNodeSize = "Large"
$clusterHeadSize = "Large"
$clusterZooSize = "Small"
$managedDisksPerNode = 3
$location = Get-AutomationVariable -Name 'Location_BR'
$Net= Get-AutomationVariable -Name 'Net'
$Subnet="SUBNETNATDEV-AZ1-Public"
$VirtualNetworkId = "/subscriptions/" + $subscriptionID + "/resourceGroups/RedeNaturaGeral/providers/Microsoft.Network/virtualNetworks/" + $Net
$SubnetName= $VirtualNetworkId + "/subnets/" + $Subnet



#3. Deploy
Write-Output "Deploying..." 
   
    New-AzureRmHDInsightCluster -OSType $clusterOS `
        -ClusterType $clusterType `
        -ClusterSizeInNodes $clusterNodes `
        -ResourceGroupName $resourceGroupName `
        -ClusterName $clusterName `
        -HeadNodeSize $clusterHeadSize `
        -WorkerNodeSize $clusterNodeSize `
        -ZookeeperNodeSize  $clusterZooSize `
        -HttpCredential $clusterCredential `
        -SshCredential $sshCredential `
        -Location $location `
        -Version $hdpversion `
        -VirtualNetworkId $VirtualNetworkId `
        -SubnetName $SubnetName `
        -DefaultStorageAccountName "$storageAccountName.blob.core.windows.net" `
        -DefaultStorageAccountKey $storageAccountKey `
        -DefaultStorageContainer $containerName `
        -DisksPerWorkerNode $managedDisksPerNode 
    

#4. Action Scripts

Write-Output "ActionScript: Add Modules"
Submit-AzureRmHDInsightScriptAction `
-ClusterName $clusterName `
-Name "add modules" `
-NodeTypes "HeadNode" `
-Parameters " " `
-ResourceGroupName "$resourceGroupName" `
-Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_modules.sh
Write-Output "============================================================"

Write-Output "ActionScript: Add Topics"
Submit-AzureRmHDInsightScriptAction `
-ClusterName $clusterName `
-Name "add topics" `
-NodeTypes "HeadNode" `
-Parameters "$clusterName $clusterCredential" `
-ResourceGroupName "$resourceGroupName" `
-Uri https://$storageAccountName.blob.core.windows.net/startup/action-script/add_topics_kafka.sh
Write-Output "============================================================"



Write-Output "Término da execução" 