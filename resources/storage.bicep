// =========== storage.bicep ===========

param storageAccountName string
param location string = resourceGroup().location

resource stg 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: true
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Disabled'
  }
}

output storageID string = stg.id
