## Customize for Your Environment

$ResourceGroupNameSource = "manageiq"
$ResourceGroupNameDest = "cfme-group"
$StorageAccountName = "vhdstorage"

$BlobNameSource = "manageiq-azure-darga-4.1.vhd"
$BlobSourceContainer = "templates"

$BlobNameDest = "cfme-test.vhd"
$BlobDestinationContainer = "vhds"
$VMName = "cfme-test"
$DeploySize= "Standard_D3_v2"
$vmUserName = "azureuser"

$InterfaceName = "cfme-nic"
$VNetName = "cfme-vnet"
$PublicIPName = "cfme-public-ip"

$SSHKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrpo1Dg8ssRNDweKIO+Y1vcej6G+LXGQd66cDU7RcxDWUSdxkGSKWDQIRTWXC7Iwu6e+6Z1l7nbbjjhSR808gi6TKGRwJbFAeHMsZ1Ci5ffmQkU7Z7XujdoOfOclGEo76NKhqy2oDRrsE8RFDvkxc1wAPCIgsSzc+j2u01nGqsT+rBweWq/+nVLSqIpmLtbR3BxWAoM8NFBxpHmVJgzYluHcYk9SbqWu5zF6BKNpIlx8mSSCe+gM6ELZuCytSGxr3+TLOgpTXcHPxqeZ8yJ+93pCPjfjczAAr81na/4NSuPGEcAI6Ns00fxTf2/UOWyEu9YlkM4F419vHCpa/vaWYL vagrant@localhost.localdomain"

##

$StorageAccount = Get-AzureRmStorageAccount -ResourceGroup $ResourceGroupNameSource -Name $StorageAccountName

$SourceImageUri = "https://$StorageAccountName.blob.core.cloudapi.de/templates/$BlobNameSource"
$Location = $StorageAccount.Location
$OSDiskName = $VMName

# Network
$Subnet1Name = "default"
$VNetAddressPrefix = "10.1.0.0/16"
$VNetSubnetAddressPrefix = "10.1.0.0/24"
$PIp = New-AzureRmPublicIpAddress -Name $PublicIPName -ResourceGroupName $ResourceGroupNameDest -Location $Location -AllocationMethod Dynamic -Force
$SubnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name $Subnet1Name -AddressPrefix $VNetSubnetAddressPrefix
$VNet = New-AzureRmVirtualNetwork -Name $VNetName -ResourceGroupName $ResourceGroupNameDest -Location $Location -AddressPrefix $VNetAddressPrefix -Subnet $SubnetConfig -Force
$Interface = New-AzureRmNetworkInterface -Name $InterfaceName -ResourceGroupName $ResourceGroupNameDest -Location $Location -SubnetId $VNet.Subnets[0].Id -PublicIpAddressId $PIp.Id -Force

# Specify the VM Name and Size
$VirtualMachine = New-AzureRmVMConfig -VMName $VMName -VMSize $DeploySize

# Add User
$cred = Get-Credential -UserName $VMUserName -Message "Setting user credential - use blank password"
$VirtualMachine = Set-AzureRmVMOperatingSystem -VM $VirtualMachine -Linux -ComputerName $VMName -Credential $cred

# Add NIC
$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $Interface.Id

# Add Disk
$OSDiskUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + $BlobDestinationContainer + "/" + $BlobNameDest

$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption FromImage -SourceImageUri $SourceImageUri -Linux

# Set SSH key
Add-AzureRmVMSshPublicKey -VM $VirtualMachine -Path "/home/$VMUserName/.ssh/authorized_keys" -KeyData $SSHKey

# Create the VM
New-AzureRmVM -ResourceGroupName $ResourceGroupNameDest -Location $Location -VM $VirtualMachine
