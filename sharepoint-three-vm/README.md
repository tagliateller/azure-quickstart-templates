# Create a new Sharepoint Farm with 3 VMs

This template creates three new Azure VMs, each with a public IP address and load balancer and a VNet, it configures one VM to be an AD DC for a new Forest and Domain, one with SQL Server 2014 SP1 domain joined and a third VM with a Sharepoint 2013 farm and site, all VMs have public facing RDP

Click the button below to deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fsharepoint-three-vm%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fsharepoint-three-vm%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

Notes: Sharepoint farm name must not contain spaces.

# Aktuell


PS C:\Users\Robert\Workspace\azure-quickstart-templates\sharepoint-three-vm> New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupName sharepoint10 -TemplateFi
le .\azuredeploy.json –TemplateParameterFile .\azuredeploy.parameters.local.json
New-AzureRmResourceGroupDeployment : 12:22:44 - Resource Microsoft.Compute/virtualMachines 'spfarm-sp' failed with message '{
  "error": {
    "code": "ImageNotFound",
    "target": "imageReference",
    "message": "The platform image 'MicrosoftSharePoint:MicrosoftSharePointServer:2013:latest' is not available. Verify that all fields in the storage profile are
correct."
  }
}'
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:22:44 - Resource Microsoft.Compute/virtualMachines 'spfarm-sql' failed with message '{
  "error": {
    "code": "ImageNotFound",
    "target": "imageReference",
    "message": "The platform image 'MicrosoftSQLServer:SQL2014SP1-WS2012R2:Standard:latest' is not available. Verify that all fields in the storage profile are correct."
  }
}'
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:23:06 - Resource Microsoft.Resources/deployments 'ProvisioningSharepointVM' failed with message '{
  "status": "Failed",
  "error": {
    "code": "ResourceDeploymentFailure",
    "message": "The resource operation completed with terminal provisioning state 'Failed'.",
    "details": [
      {
        "code": "DeploymentFailed",
        "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-debug for usage
details.",
        "details": [
          {
            "code": "NotFound",
            "message": "{\r\n  \"error\": {\r\n    \"code\": \"ImageNotFound\",\r\n    \"target\": \"imageReference\",\r\n    \"message\": \"The platform image
'MicrosoftSharePoint:MicrosoftSharePointServer:2013:latest' is not available. Verify that all fields in the storage profile are correct.\"\r\n  }\r\n}"
          }
        ]
      }
    ]
  }
}'
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:23:06 - At least one resource deployment operation failed. Please list deployment operations for details. Please see
https://aka.ms/arm-debug for usage details.
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:23:06 - Resource Microsoft.Resources/deployments 'ProvisioningSQLServerVM' failed with message '{
  "status": "Failed",
  "error": {
    "code": "ResourceDeploymentFailure",
    "message": "The resource operation completed with terminal provisioning state 'Failed'.",
    "details": [
      {
        "code": "DeploymentFailed",
        "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-debug for usage
details.",
        "details": [
          {
            "code": "NotFound",
            "message": "{\r\n  \"error\": {\r\n    \"code\": \"ImageNotFound\",\r\n    \"target\": \"imageReference\",\r\n    \"message\": \"The platform image
'MicrosoftSQLServer:SQL2014SP1-WS2012R2:Standard:latest' is not available. Verify that all fields in the storage profile are correct.\"\r\n  }\r\n}"
          }
        ]
      }
    ]
  }
}'
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:23:06 - At least one resource deployment operation failed. Please list deployment operations for details. Please see
https://aka.ms/arm-debug for usage details.
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:26:11 - Resource Microsoft.Compute/virtualMachines/extensions 'spfarm-ad/InstallDomainController' failed with message '{
  "error": {
    "code": "ArtifactNotFound",
    "message": "Extension with publisher 'Microsoft.Powershell', type 'DSC', and type handler version '2.17' could not be found in the extension repository."
  }
}'
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:27:03 - Resource Microsoft.Resources/deployments 'ProvisioningADDomainController' failed with message '{
  "status": "Failed",
  "error": {
    "code": "ResourceDeploymentFailure",
    "message": "The resource operation completed with terminal provisioning state 'Failed'.",
    "details": [
      {
        "code": "DeploymentFailed",
        "message": "At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-debug for usage
details.",
        "details": [
          {
            "code": "NotFound",
            "message": "{\r\n  \"error\": {\r\n    \"code\": \"ArtifactNotFound\",\r\n    \"message\": \"Extension with publisher 'Microsoft.Powershell', type 'DSC', and
type handler version '2.17' could not be found in the extension repository.\"\r\n  }\r\n}"
          }
        ]
      }
    ]
  }
}'
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:27:03 - At least one resource deployment operation failed. Please list deployment operations for details. Please see
https://aka.ms/arm-debug for usage details.
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:27:03 - Template output evaluation skipped: at least one resource deployment operation failed. Please list deployment operations
for details. Please see https://aka.ms/arm-debug for usage details.
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet

New-AzureRmResourceGroupDeployment : 12:27:03 - Template output evaluation skipped: at least one resource deployment operation failed. Please list deployment operations
for details. Please see https://aka.ms/arm-debug for usage details.
In Zeile:1 Zeichen:1
+ New-AzureRmResourceGroupDeployment -Name spdeploy10 -ResourceGroupNam ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [New-AzureRmResourceGroupDeployment], Exception
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.NewAzureResourceGroupDeploymentCmdlet



DeploymentName          : spdeploy10
ResourceGroupName       : sharepoint10
ProvisioningState       : Failed
Timestamp               : 13.11.2016 11:26:10
Mode                    : Incremental
TemplateLink            :
Parameters              :
                          Name             Type                       Value
                          ===============  =========================  ==========
                          sharepointFarmName  String                     spfarm
                          location         String                     germanycentral
                          virtualNetworkName  String                     spfarmVNET
                          virtualNetworkAddressRange  String                     10.0.0.0/16
                          adSubnet         String                     10.0.0.0/24
                          sqlSubnet        String                     10.0.1.0/24
                          spSubnet         String                     10.0.2.0/24
                          adNicIPAddress   String                     10.0.0.4
                          adminUsername    String                     admin123
                          adminPassword    SecureString
                          adVMSize         String                     Standard_DS1_v2
                          sqlVMSize        String                     Standard_DS3_v2
                          spVMSize         String                     Standard_DS3_v2
                          domainName       String                     contoso.local
                          sqlServerServiceAccountUserName  String                     admin123sql
                          sqlServerServiceAccountPassword  SecureString
                          sharePointSetupUserAccountUserName  String                     admin123sp
                          sharePointSetupUserAccountPassword  SecureString
                          sharePointFarmAccountUserName  String                     sp_farm
                          sharePointFarmAccountPassword  SecureString
                          sharePointFarmPassphrasePassword  SecureString
                          spSiteTemplateName  String                     STS#0
                          spDNSPrefix      String                     spcluster
                          baseUrl          String                     https://raw.githubusercontent.com/tagliateller/azure-quickstart-templates/master/sharepoint-three-vm
                          spPublicIPNewOrExisting  String                     new
                          spPublicIPRGName  String
                          sppublicIPAddressName  String                     sppublicIP
                          storageAccountNamePrefix  String                     spstorage
                          storageAccountType  String                     Premium_LRS

Outputs                 :
DeploymentDebugLogLevel :



PS C:\Users\Robert\Workspace\azure-quickstart-templates\sharepoint-three-vm>






