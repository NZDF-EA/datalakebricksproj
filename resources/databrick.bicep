param location string
param workspaceName string
param publicSubnetName string
param privateSubnetName string
param vnetid string
var managedResourceGroupName = 'databricks-rg-${workspaceName}-${uniqueString(workspaceName, resourceGroup().id)}'

resource symbolicname 'Microsoft.Databricks/workspaces@2021-04-01-preview' = {
  name: workspaceName
  location: location
  sku: {
    name: 'Premium'
  }
  properties: {
    managedResourceGroupId: subscriptionResourceId('Microsoft.Resources/resourceGroups', managedResourceGroupName)
    parameters: {
      customVirtualNetworkId: {
        value: vnetid
      }
      customPublicSubnetName: {
        value: publicSubnetName
      }
      customPrivateSubnetName: {
        value: privateSubnetName
      }
      enableNoPublicIp: {
        value: true
      }
    }
  }
}
