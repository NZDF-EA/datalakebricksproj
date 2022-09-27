// =========== storage.bicep ===========

param storageAccountName string
param location string = resourceGroup().location
//param location string = 'australia'

resource stg 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: true
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Disabled'
  }
}

output storageID string = stg.id
