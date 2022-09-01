// =========== main.bicep ===========

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string

// variables
param location string = resourceGroup().location
var vnetname = 'adlvnet'
var vnetAddressPrefix = '10.0.0.0/16'
var subnet1Prefix = '10.0.0.0/24'
var subnet1Name = 'subnet1'
var subnet2Prefix = '10.0.1.0/24'
var subnet2Name = 'subnet2'
var subnet3Prefix = '10.0.2.0/24'
var subnet3Name = 'subnet3'
var storageAccountName = 'adlstorage1${uniqueString(resourceGroup().id)}'
var nicName = 'adlvmnic'
var vmName = 'simple-vm'
var vmSize = 'Standard_D2s_v3'
var OSVersion = '2019-datacenter-gensecond'
var adminUsername = 'Datauser1'
var dbworkspacename = 'DataLakePOC'
var sqldbName = 'DataLakePOCDb'

// Deploying VNet
module vnet './resources/network.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: vnetname
    vnetAddressPrefix: vnetAddressPrefix
    subnet1Prefix: subnet1Prefix
    subnet1Name: subnet1Name
    subnet2Prefix: subnet2Prefix
    subnet2Name: subnet2Name
    subnet3Prefix: subnet3Prefix
    subnet3Name: subnet3Name   
    location: location
  }
}

// Deploying storage account from storage bicep
module stg './resources/storage.bicep' = {
  name: 'storageDeployment'
  params: {
    location: location
    storageAccountName: storageAccountName
  }
}

// Deploying private endpoint from privateep bicep
module pvtepstor './resources/privateep.bicep' = {
  name: 'privateEndpointDeploymentStor'
  params: {
    location: location
    subnetref: '${vnet.outputs.vnetID}/subnets/${subnet1Name}'
    resourceref: stg.outputs.storageID
    gpids: 'blob'
    epname: 'StorageEP1'
  }
}

// Deploying virtual machine from vm bicep
module vm './resources/vm.bicep' = {
  name: 'vmDeployment'
  params: {
    location: location
    adminUsername: adminUsername
    adminPassword: adminPassword
    OSVersion: OSVersion
    vmSize: vmSize
    vmName: vmName
    nicName: nicName
    subnetID: vnet.outputs.subnetId1
  }
}

// Deploying databricks from db bicep
module databrick './resources/databrick.bicep' = {
  name: 'databrickDeployment'
  params: {
    location: location
    workspaceName: dbworkspacename
    publicSubnetName: subnet2Name
    privateSubnetName: subnet3Name
    vnetid: vnet.outputs.vnetID
  }
}

// Deploying sqldb from sqldb bicep
module sqldb './resources/sqldb.bicep' = {
  name: 'sqlDeployment'
  params: {
    location: location
    // publicSubnetName: vnet.outputs.subnetId1
    // privateSubnetName: subnet3Name
    // vnetid: vnet.outputs.vnetID
    administratorLoginPassword: adminPassword
    administratorLogin: adminUsername
    sqlDBName: sqldbName
    sqlServerName: uniqueString('sql', resourceGroup().id)
  }
}

// Deploying private endpoint from privateep bicep
module pvtepsql './resources/privateep.bicep' = {
  name: 'privateEndpointDeploymentSQL'
  params: {
    location: location
    subnetref: '${vnet.outputs.vnetID}/subnets/${subnet1Name}'
    resourceref: sqldb.outputs.sqlserverID
    gpids: 'sqlServer'
    epname: 'SQLEP1'
  }
}
