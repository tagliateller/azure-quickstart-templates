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

Lösung:

   13  sudo systemctl status origin-master
   14  sudo grep /var/log/messages | grep DNS
   15  sudo cat /var/log/messages |grep DNS
   16  sudo systemctl status dnsmasq
   17  sudo systemctl stop dnsmasq
   18  sudo systemctl status dnsmasq
   19  sudo systemctl restart origin-master
   20  sudo cat /var/log/messages |grep DNS
   21  dig @master.mvolmytcsyye3k3etuaeswecob.ax.internal.azurecloudapp.de +short kubernetes.default.svc.cluster.local
 
[azureuser@master ~]$ dig @master.mvolmytcsyye3k3etuaeswecob.ax.internal.azurecloudapp.de +short kubernetes.default.svc.cluster.local
172.30.0.1
[azureuser@master ~]$

Reparaturversuch: 

[azureuser@master ~]$ oc get pods
NAME                     READY     STATUS    RESTARTS   AGE
metrics-deployer-ufbl5   0/1       Error     0          17h

[azureuser@master ~]$ oc delete all,sa,templates,secrets,pvc --selector="metrics-infra"
pod "metrics-deployer-ufbl5" deleted
[azureuser@master ~]$ oc get pods
[azureuser@master ~]$

[azureuser@master ~]$ oc new-app --as=system:serviceaccount:openshift-infra:metrics-deployer -f /home/azureuser/openshift-ansible/roles/openshift_hosted_templates/files/v1.3/origin/metrics-deployer.yaml -p HAWKULAR_METRICS_HOSTNAME=metrics.tagliateller.nu

--> geht noch nicht, was steht im logfile

+ oc config set-cluster deployer-master --api-version=v1 --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt --server=https://kubernetes.default.svc:443
cluster "deployer-master" set.
++ cat /var/run/secrets/kubernetes.io/serviceaccount/token
+ oc config set-credentials deployer-account --token=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJvcGVuc2hpZnQtaW5mcmEiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlY3JldC5uYW1lIjoibWV0cmljcy1kZXBsb3llci10b2tlbi04ZmdkeSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJtZXRyaWNzLWRlcGxveWVyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQudWlkIjoiZDA2NmZkOGQtYmY5Yy0xMWU2LWJlNjgtMDAxN2ZhMTAwMTYxIiwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Om9wZW5zaGlmdC1pbmZyYTptZXRyaWNzLWRlcGxveWVyIn0.sqchAc1M6C1ppEEHAFznlIt5BMey1DjZN83XXIjUdHV5pzCyqidjorLzq_sORYdnoU4c2_uljHstHo6spRdC719c-9Ysj_ZX7cG7vpw0-hK0Sq3E2D4LrScZYHaYVVmJyPoJxFCyFChuo8mMY_3reTILKG6ODmaHQhRuHPNqstkB4fL8feQRWoRh8riZOaH18BLabl8wD98zkSwd8Q_Wtv64Qzn4fv_pXyYJI-mZrQLQJICIgJLuoKBD2wHpL2CKbYy0aRr6dtbDivBTs93z2QQVopqWPCzJ5lTocdPOQgToYR_E8Aej4drvegU5N8OcVdCC6A9yIinCtJceesQ4ew
user "deployer-account" set.
+ oc config set-context deployer-context --cluster=deployer-master --user=deployer-account --namespace=openshift-infra
context "deployer-context" set.
+ '[' -n 1 ']'
+ oc config use-context deployer-context
switched to context "deployer-context".
+ case $deployer_mode in
+ '[' false '!=' true ']'
+ validate_preflight
+ set +x

PREFLIGHT CHECK FAILED
========================
validate_master_accessible:
unable to access master url https://kubernetes.default.svc:443
See the error from 'curl https://kubernetes.default.svc:443' below for details:
curl: (6) Could not resolve host: kubernetes.default.svc; Name or service not known

Deployment has been aborted prior to starting, as these failures often indicate fatal problems.
Please evaluate any error messages above and determine how they can be addressed.
To ignore this validation failure and continue, specify IGNORE_PREFLIGHT=true.

PREFLIGHT CHECK FAILED
[azureuser@master ~]$ dig @master.mvolmytcsyye3k3etuaeswecob.ax.internal.azurecloudapp.de +short kubernetes.default.svc
[azureuser@master ~]$ dig @master.mvolmytcsyye3k3etuaeswecob.ax.internal.azurecloudapp.de +short kubernetes.default.svc.cluster.local
172.30.0.1
[azureuser@master ~]$

Warum kubernetes.default.svc ? Warum nicht kubernetes.default.svc.cluster.local ??

Reparatur DNS mit Stop dnsmasq und restart master -> dann kann kubernetes.default.svc.cluster.local aufgelöst werden

oc new-app --as=system:serviceaccount:openshift-infra:metrics-deployer -f /home/azureuser/openshift-ansible/roles/openshift_hosted_templates/files/v1.3/origin/metrics-deployer.yaml -p HAWKULAR_METRICS_HOSTNAME=metrics.tagliateller.nu -p MASTER_URL=https://kubernetes.default.svc.cluster.local:443

resolver (resolv.conf) prüfen, ping und curl gehen so nicht

DNS-Thema wird auch hier behandelt: https://keithtenzer.com/2016/08/04/openshift-enterprise-3-2-all-in-one-lab-environment/
ggf. einen eigenen Bind aufsetzen

zunächst mit dnsmasq=true versuchen

OK - so geht es 

[azureuser@master ~]$ oc get pods
NAME                         READY     STATUS      RESTARTS   AGE
hawkular-cassandra-1-eu0wk   1/1       Running     0          1d
hawkular-metrics-sqcn2       1/1       Running     0          1d
heapster-r9tgr               1/1       Running     0          1d
metrics-deployer-w5fo6       0/1       Completed   0          1d
[azureuser@master ~]$

wie kann metrics angesprochen werden ?

https://hawkular-metrics.apps.tagliateller.nu -> nur statusanzeige

wo sehe ich die metrics ?
--> nur in der Console oder in CloudForms / ManageIQ
in Cloudforms / ManageIQ kann in Chargeback der Provider ausgewählt werden, das geht auch mit Containern
Frage: Wie kann man einen Chargeback-Report in CloudForms / ManageIQ erstellen ?

# Zugriff auf Hawkular Metrics

#curl -u azureuser -kv -H "X-CSRF-TOKEN: xxx" 'https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443/oauth/authorize?client_id=openshift-challenging-client&response_type=token'
#curl -L -k -H "X-Remote-User: azureuser" https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443/oauth/token/request
#curl -k -v -H 'X-Csrf-Token: 1' 'https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443/oauth/authorize?client_id=openshift-challenging-client&response_type=token'   
#curl -k -v -H 'X-Csrf-Token: 1' '<redirected challengeURL from step 3 +query>'
#curl -k -v -u azureuser:<your_password> -H 'X-Csrf-Token: 1' '<redirected_challengeURL_from_step_3 +query>'

OK: 
curl -u azureuser:XXXXX -k -v -H 'X-Csrf-Token: 1' 'https://osev3master.germanycentral.cloudapp.microsoftazure.de:8443/oauth/authorize?client_id=openshift-challenging-client&response_type=token'
(nach https://docs.openshift.org/latest/install_config/configuring_authentication.html#token-options)

https://docs.openshift.org/latest/install_config/cluster_metrics.html#cluster-metrics-accessing-hawkular-metrics-directly
http://www.hawkular.org/docs/rest/rest-metrics.html#GET__tenants

FAILED:

$ curl -k --header "Authorization: Bearer XXXXX" https://hawkular-metrics.apps.tagliateller.nu/hawkular/metrics/tenants
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    76  100    76    0     0    180      0 --:--:-- --:--:-- --:--:--   186<html><head><title>Error</title></head><body>400 - Bad Request</body></html>

Robert@LAPTOP-JMEHTUQA MINGW64 ~
$
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

