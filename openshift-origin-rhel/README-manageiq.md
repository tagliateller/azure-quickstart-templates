# Azure Powershell 

https://www.microsoft.com/web/downloads/platform.aspx
Azure Powershell suchen und installieren

# ManageIQ

http://manageiq.org/docs/reference/latest/doc-Installing_on_Microsoft_Azure/miq/

# Expand Disk

https://www.considerednormal.com/2014/09/resizing-vhd-files-the-easy-way/

C:\Users\azureuser\Downloads>diskpart

Microsoft DiskPart version 10.0.14393.0

Copyright (C) 1999-2013 Microsoft Corporation.
On computer: CTRL16

DISKPART> Select vdisk file="c:\Users\azureuser\Downloads\manageiq-azure-darga-4.1.vhd"

DiskPart successfully selected the virtual disk file.

DISKPART> expand vdisk maximum=60000

  100 percent completed

DiskPart successfully expanded the virtual disk file.

DISKPART>

# Anmelden

Add-AzureRmAccount -EnvironmentName AzureGermanCloud

# Resource-Gruppev anlegen

$Location = "Germany Central"

New-AzureRmResourceGroup -Name manageiq -Location "Germany Central"

# Storage-Account anlegen

$ResourceGroupName = "manageiq"

# New-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName –StorageAccountName $StorageAccountName -Location $Location

# Hochladen des Image

$StorageAccountName = "vhdstorage"

$BlobNameSource = "manageiq-azure-darga-4.1.vhd"
$BlobSourceContainer = "templates"
$LocalImagePath = "C:\Users\azureuser\Downloads\manageiq-azure-darga-4.1.vhd"

##

# Upload VHD to a "templates" directory. You can pass a few arguments, such as `NumberOfUploaderThreads 8`. The default number of uploader threads is `8`. See https://msdn.microsoft.com/en-us/library/mt603554.aspx

Add-AzureRmVhd -ResourceGroupName $ResourceGroupName -Destination https://$StorageAccountName.blob.core.cloudapi.de/$BlobSourceContainer/$BlobNameSource -LocalFilePath $LocalImagePath -NumberOfUploaderThreads 8

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

# TODO

https://docs.microsoft.com/de-de/azure/virtual-machines/virtual-machines-windows-classic-createupload-vhd?toc=%2fazure%2fvirtual-machines%2fwindows%2fclassic%2ftoc.json#schritt-3-hochladen-der-vhd-datei


# OpenShift API Toekn

oc sa get-token -n management-infra management-admin

# OpenSCAP Policy

* muss dem Provider zugeordnet werden
* 
