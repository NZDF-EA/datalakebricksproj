
param location string = resourceGroup().location
param subnetref string
param storageref string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: 'PrivateEndpoint1'
  location: location
  properties: {
    subnet: {
      id: subnetref
    }
    privateLinkServiceConnections: [
      {
        properties: {
          privateLinkServiceId: storageref
          groupIds: [
            'blob'
          ]
        }
        name: 'PrivateEndpoint1'
      }
    ]
  }
}
