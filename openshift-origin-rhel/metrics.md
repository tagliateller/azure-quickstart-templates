# Deployment Metrics (Hawkular)

## master

### zum Projekt wechseln

oc project openshift-infra

### serviceaccount erzeugen

[azureuser@master ~]$ oc create -f - <<API
> apiVersion: v1
> kind: ServiceAccount
> metadata:
>   name: metrics-deployer
> secrets:
> - name: metrics-deployer
> API
serviceaccount "metrics-deployer" created
[azureuser@master ~]$

### serviceaccount rechte vergeben

oadm policy add-role-to-user edit system:serviceaccount:openshift-infra:metrics-deployer
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:openshift-infra:heapster
	
### dummy for the secret

oc secrets new metrics-deployer nothing=/dev/null

### deployer-template bearbeiten

 cp /home/azureuser/openshift-ansible/roles/openshift_hosted_templates/files/v1.4/origin/metrics-deployer.yaml .

```yaml
...
  description: "If preflight validation is blocking deployment and you're sure you don't care about it, this will ignore the results and proceed to deploy."
  name: IGNORE_PREFLIGHT
  value: "false"
-
  description: "Set to true for persistent storage, set to false to use non persistent storage"
  name: USE_PERSISTENT_STORAGE
  value: "false"
-
  description: "Set to true to dynamically provision storage, set to false to use use pre-created persistent volumes"
  name: DYNAMICALLY_PROVISION_STORAGE
...
```

```yaml
  value: "latest"
-
  description: "Internal URL for the master, for authentication retrieval"
  name: MASTER_URL
  value: "https://master.rfqyi4rngtludat0wuchmaqu5g.ax.internal.azurecloudapp.de:8443"
-
  description: "External hostname where clients will reach Hawkular Metrics"
  name: HAWKULAR_METRICS_HOSTNAME
  required: true
-
```


```yaml
  description: "External hostname where clients will reach Hawkular Metrics"
  name: HAWKULAR_METRICS_HOSTNAME
  value: "metrics.tagliateller.nu"
  required: true
```
  
oc new-app --as=system:serviceaccount:openshift-infra:metrics-deployer -f metrics-deployer.yaml
	
oc adm policy add-role-to-user view system:serviceaccount:openshift-infra:hawkular -n openshift-infra 
(ist erforderlich, sonst crasht ein pod)

oc adm policy add-role-to-user view system:serviceaccount:openshift-infra:hawkular -n openshift-infra

### URL

???
https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443/hawkular/metrics

### Löschen

oc delete all,sa,templates,secrets,pvc --selector="metrics-infra"

### Troubleshooting

TODO: https://github.com/openshift/origin-metrics


DNS:

dig @$OPENSHIFT_MASTER +short kubernetes.default.svc.cluster.local
dig @master.rfqyi4rngtludat0wuchmaqu5g.ax.internal.azurecloudapp.de +short kubernetes.default.svc.cluster.local

[azureuser@master ~]$ sudo cat /var/log/messages | grep DNS
Dec 11 10:42:02 master origin-master: W1211 10:42:02.764559   52524 run_components.go:210] Could not start DNS: listen tcp4 0.0.0.0:53: bind: address already in use
[azureuser@master ~]$



## Backup

master:

oc login -u system:admin -n default
oc project logging

oc new-app logging-deployer-account-template

oadm policy add-cluster-role-to-user oauth-editor system:serviceaccount:logging:logging-deployer
oadm policy add-scc-to-user privileged system:serviceaccount:logging:aggregated-logging-fluentd
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:logging:aggregated-logging-fluentd

oc create configmap logging-deployer --from-literal kibana-hostname=osev3kibana.germanycentral.cloudapp.microsoftazure --from-literal public-master-url=https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443 --from-literal es-cluster-size=3 --from-literal es-instance-ram=8G

oc create secret generic logging-deployer

oc new-app logging-deployer-template

