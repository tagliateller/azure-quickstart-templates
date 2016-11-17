master:

oc new-app logging-deployer-account-template

oadm policy add-cluster-role-to-user oauth-editor system:serviceaccount:logging:logging-deployer
oadm policy add-scc-to-user privileged system:serviceaccount:logging:aggregated-logging-fluentd
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:logging:aggregated-logging-fluentd

oc create configmap logging-deployer --from-literal kibana-hostname=kibana.example.com --from-literal public-master-url=https://master.example.com:8443 --from-literal es-cluster-size=3 --from-literal es-instance-ram=8G
