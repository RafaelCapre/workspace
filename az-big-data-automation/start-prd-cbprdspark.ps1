#0. Sign in
$azureCredential = Get-AutomationPSCredential -Name 'azureautomation'
$azureCredential
Login-AzureRmAccount -Credential $azureCredential

#1. Select the subscription to use
$subscriptionID = Get-AutomationVariable -Name 'subscription-id'
Select-AzureRmSubscription -SubscriptionId $subscriptionID
Write-Output "Subscription: " $subscriptionID 

#2. Cluster Variables
$resourceGroupName = "redenaturageral"
$storageAccountName = "hdiprdstorage"
$containerName = "cbprdspark"
$storageAccountKey = Get-AutomationVariable -Name 'hdiprdstoragekeycb'
$clusterName = $containerName 
$clusterCredential = Get-AutomationPSCredential -Name 'cred-admin-cbprdspark'
$sshCredential = Get-AutomationPSCredential -Name 'cred-sshuser-cbprdspark'
$clusterType = "Spark"
$hdpversion = "3.6"
$clusterOS = "Linux"
$clusterNodes = 3
$clusterNodeSize = "Standard_D12"
$clusterHeadSize = "Standard_D12"
$location = Get-AutomationVariable -Name 'Location_BR'
$Subnet="SUBNETNATPRD-AZ1-Private"
$VirtualNetworkId = "/subscriptions/" + $subscriptionID + "/resourceGroups/RedeNaturaGeral/providers/Microsoft.Network/virtualNetworks/" + $Net
$SubnetName= $VirtualNetworkId + "/subnets/" + $Subnet



$passwd = $clusterCredential.GetNetworkCredential().password
$passwd


#4. Deploy
Write-Output "Executando:" 
New-AzureRmHDInsightClusterConfig -ClusterType $clusterType `
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


Write-Output "Término da execução" 