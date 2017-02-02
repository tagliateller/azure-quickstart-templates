# Login
azure login

# Key Vault
azure group create -n keys -l "East US"
azure keyvault create -u defaultkeyvault -g keys -l 'East US'

# Resource Mode
azure config mode arm

# Gruppe anlegen
azure group create -n origin10 -l "East US"

# Template validieren
azure group template validate -f azuredeploy.json -e azuredeploy.local.params.json -g origin10
