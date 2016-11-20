
# ManageIQ

http://manageiq.org/docs/reference/latest/doc-Installing_on_Microsoft_Azure/miq/


# Resource-Gruppe anlegen
# Storage-Account anlegen

# Hochladen des Image

$ResourceGroupName = "manageiq"
$StorageAccountName = "vhdstorage"

$BlobNameSource = "cfme-test.vhd"
$BlobSourceContainer = "templates"
$LocalImagePath = "C:\tmp\$BlobNameSource"

##

# Upload VHD to a "templates" directory. You can pass a few arguments, such as `NumberOfUploaderThreads 8`. The default number of uploader threads is `8`. See https://msdn.microsoft.com/en-us/library/mt603554.aspx

Add-AzureRmVhd -ResourceGroupName $ResourceGroupName -Destination https://$StorageAccountName.blob.core.windows.net/$BlobSourceContainer/$BlobNameSource -LocalFilePath $LocalImagePath -NumberOfUploaderThreads 8

# Anlegen der VM

Create a virtual machine. Then, define your VM and VHD name, your system/deployment name and size. Next, you will set the appropriate Storage, Network and Configuration options for your environment.

Example Script:

## Customize for Your Environment

$ResourceGroupName = "manageiq"
$StorageAccountName = "vhdstorage"

$BlobNameSource = "manageiq-azure-darga-4.1.vhd"
$BlobNameDest = "manageiq-azure-darga-4.1.vhd"
$BlobDestinationContainer = "vhds"
$VMName = "cfme-test"
$DeploySize= "Standard_D3_v2"
$vmUserName = "azureuser"

$InterfaceName = "test-nic"
$VNetName = "test-vnet"
$PublicIPName = "test-public-ip"

$SSHKey = <your ssh public key>

##

$StorageAccount = Get-AzureRmStorageAccount -ResourceGroup $ResourceGroupName -Name $StorageAccountName

$SourceImageUri = "https://$StorageAccountName.blob.core.cloudapi.de/templates/$BlobNameSource"
$Location = $StorageAccount.Location
$OSDiskName = $VMName

# Network
$Subnet1Name = "default"
$VNetAddressPrefix = "10.1.0.0/16"
$VNetSubnetAddressPrefix = "10.1.0.0/24"
$PIp = New-AzureRmPublicIpAddress -Name $PublicIPName -ResourceGroupName $ResourceGroupName -Location $Location -AllocationMethod Dynamic -Force
$SubnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name $Subnet1Name -AddressPrefix $VNetSubnetAddressPrefix
$VNet = New-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VNetAddressPrefix -Subnet $SubnetConfig -Force
$Interface = New-AzureRmNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupName -Location $Location -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $PIp.Id -Force

# Specify the VM Name and Size
$VirtualMachine = New-AzureRmVMConfig -VMName $VMName -VMSize $DeploySize

# Add User
$cred = Get-Credential -UserName $VMUserName -Message "Setting user credential - use blank password"
$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Linux -ComputerName $VMName -Credential $cred

# Add NIC
$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id

# Add Disk
$OSDiskUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + $BlobDestinationContainer + "/" + $BlobNameDest

$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption fromImage -SourceImageUri $SourceImageUri -Linux

# Set SSH key
Add-AzureRmVMSshPublicKey -VM $VirtualMachine -Path “/home/$VMUserName/.ssh/authorized_keys” -KeyData $SSHKey

# Create the VM
New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $VirtualMachine
