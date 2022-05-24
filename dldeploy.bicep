// =========== main.bicep ===========

// Setting target scope
targetScope = 'subscription'

// Creating resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'rg-adltest'
  location: 'australiacentral'
}

// Deploying storage account from storage bicep
module stg './storage.bicep' = {
  name: 'storageDeployment'
  scope: rg    
  params: {
    storageAccountName: 'stcontoso'
  }
}

// Deploying VNet
resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'adltest-vnet'
}
