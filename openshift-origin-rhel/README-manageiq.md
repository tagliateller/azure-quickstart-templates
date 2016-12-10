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

# OpenShift API Toekn

oc sa get-token -n management-infra management-admin

# OpenSCAP Policy

* muss dem Provider zugeordnet werden
* 
