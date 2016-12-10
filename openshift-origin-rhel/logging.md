# Installation EFK-Stack

https://docs.openshift.org/latest/install_config/aggregate_logging.html

master:

oc login -u system:admin -n default
oc project logging

oc new-app logging-deployer-account-template

oadm policy add-cluster-role-to-user oauth-editor system:serviceaccount:logging:logging-deployer
oadm policy add-scc-to-user privileged system:serviceaccount:logging:aggregated-logging-fluentd
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:logging:aggregated-logging-fluentd

oc create configmap logging-deployer --from-literal kibana-hostname=https://logging-kibana.51.4.229.174.xip.io --from-literal kibana-ops-hostname=https://logging-kibana-ops.51.4.229.174.xip.io --from-literal master-url=https://master.rfqyi4rngtludat0wuchmaqu5g.ax.internal.azurecloudapp.de:8443 --from-literal public-master-url=https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443 --from-literal es-cluster-size=3 --from-literal es-instance-ram=8G

# Hinzufügen von master-url, kibana-hostname, kibana-ops-hostname, falls im vorherigen Schritt nicht erfolgreich
# ermittlung master-url mit hostname -f
oc edit configmap logging-deployer

#### START

# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  es-cluster-size: "3"
  es-instance-ram: 8G
  kibana-hostname: osev3kibana.germanycentral.cloudapp.microsoftazure
  master-url: https://master.rfqyi4rngtludat0wuchmaqu5g.ax.internal.azurecloudapp.de:8443
  public-master-url: https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443
kind: ConfigMap
metadata:
  creationTimestamp: 2016-11-17T18:51:24Z
  name: logging-deployer
  namespace: logging
  resourceVersion: "205702"
  selfLink: /api/v1/namespaces/logging/configmaps/logging-deployer
  uid: d6ce9bb0-acf6-11e6-bed2-0017fa1005c9

#### ENDE

oc create secret generic logging-deployer

oc new-app logging-deployer-template --param IMAGE_VERSION=v1.2.0 --param MODE=install

# damit ist der Stack erfolgreich deployt 
# TODO ElasticSearch auf persistentem Volumens unterbringen

# Nodes labeln

oc label node --all logging-infra-fluentd=true

Beispiel:
[azureuser@master ~]$ oc label node --all logging-infra-fluentd=true
node "master.rfqyi4rngtludat0wuchmaqu5g.ax.internal.azurecloudapp.de" labeled
node "node-0.rfqyi4rngtludat0wuchmaqu5g.ax.internal.azurecloudapp.de" labeled

# Routen abändern

  104  oc delete route logging-kibana
  105  oc delete route logging-kibana-ops
  109  oc expose service logging-kibana --hostname logging-kibana.51.4.229.174.xip.io
  110  oc expose service logging-kibana-ops --hostname logging-kibana-ops.51.4.229.174.xip.io

# TODO: es fehlt der kibana - pod, auch das hochsetzen der replicas hilft nicht
# TODO: routen werden trotz config nicht richtig gesetzt


