#0. Sign in
$azureCredential = Get-AutomationPSCredential -Name 'azureautomation'
$azureCredential
Login-AzureRmAccount -Credential $azureCredential

#1. Select the subscription to use
$subscriptionID = Get-AutomationVariable -Name 'subscription-id'
Select-AzureRmSubscription -SubscriptionId $subscriptionID
Write-Output "Subscription: " $subscriptionID 

#2. Cluster Variables
$resourceGroupName = "DEV"
$storageAccountName = "hdidevstorage"
$containerName = "cbdevspark"
$storageAccountKey = Get-AutomationVariable -Name 'hdidevstoragekeycb'
$clusterName = $containerName 
$clusterCredential = Get-AutomationPSCredential -Name 'cred-admin-cbdevspark'
$sshCredential = Get-AutomationPSCredential -Name 'cred-sshuser-cbdevspark'
$clusterType = "Spark"
$hdpversion = "3.6"
$clusterOS = "Linux"
$clusterNodes = 1
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

