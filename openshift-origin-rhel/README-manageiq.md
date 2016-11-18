
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
