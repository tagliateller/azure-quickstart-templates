azure login
azure group create -n demov3group -l "East US"
azure group deployment create -f azuredeploy.json -e azuredeploy.parameters.json -g demov3group -n demov3deployment

eval `ssh-agent -s`
ssh-add ~/azure-key-pair
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook playbooks/byo/openshift_facts.yml -i azure.inventory

via sudo hostname [KURZ] auf allen Maschinen ändern, dann zeigt obiger Befehl auch die kurzen Namen an

jetzt Installation starten:

ansible-playbook playbooks/byo/openshift-cluster/config.yml -i azure.inventory

