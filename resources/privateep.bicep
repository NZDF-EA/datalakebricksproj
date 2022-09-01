
param location string = resourceGroup().location
param subnetref string
param resourceref string
param epname string
param gpids string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2020-06-01' = {
  name: epname
  location: location
  properties: {
    subnet: {
      id: subnetref
    }
    privateLinkServiceConnections: [
      {
        properties: {
          privateLinkServiceId: resourceref
          groupIds: [
            gpids
          ]
        }
        name: epname
      }
    ]
  }
}
