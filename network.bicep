param vnetName string
param vnetAddressPrefix string
param subnet1Name string
param subnet1Prefix string
param subnet2Name string
param subnet2Prefix string
param subnet3Name string
param subnet3Prefix string
param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1Prefix
          networkSecurityGroup: {
            location: location
            properties: {}
          }
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2Prefix
          networkSecurityGroup: {
            location: location
            properties: {}
          }
        }
      }
      {
        name: subnet3Name
        properties: {
          addressPrefix: subnet3Prefix
          networkSecurityGroup: {
            location: location
            properties: {}
          }
        }
      }      
    ]
  }
}

output vnetID string = vnet.id
output subnetId1 string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnetName, subnet1Name)
output subnetId2 string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnetName, subnet2Name)
output subnetId3 string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnetName, subnet3Name)
