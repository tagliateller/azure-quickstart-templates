# Login
azure login

# Resource Mode
azure config mode arm

# Gruppe anlegen
azure group create -n origin10 -l "East US"

# Template validieren
azure group template validate -f azuredeploy.json -e azuredeploy.local.params.json -g origin10
