$rg = 'rg-eas-demo'
$kv = 'demokv8sduifuih1'
$location = 'australiacentral'
az group create --name $rg --location $location
az keyvault create --name $kv --resource-group $rg --location $location --enabled-for-template-deployment true
#az keyvault secret set --vault-name ExampleVault --name "vmPassword1"