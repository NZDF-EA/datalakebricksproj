$rg = 'rg-eas-demo'
$location = 'australiacentral'

az group create --name $rg --location $location

# Deploy KeyVault instance
'.datalakebricksproj\kvdeploy.ps1'

az deployment group create --resource-group $rg --template-file ./main.bicep --parameters ./pass.json