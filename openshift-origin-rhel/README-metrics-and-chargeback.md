# Authentifizierung

Sende Befehl:

```bash
curl -u [USERNAME]:[USERPASSWORD] -k -v -H 'X-Csrf-Token: 1' 'https://[MASTER-URL:PORT]/oauth/authorize?client_id=openshift-challenging-client&response_type=token'
```

Response:

```bash
* timeout on name lookup is not supported
*   Trying 51.4.229.152...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* Connected to osev3master.germanycentral.cloudapp.microsoftazure.de (51.4.229.152) port 8443 (#0)
* ALPN, offering http/1.1
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
  CApath: none
* TLSv1.2 (OUT), TLS header, Certificate Status (22):
} [5 bytes data]
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
} [512 bytes data]
* TLSv1.2 (IN), TLS handshake, Server hello (2):
{ [64 bytes data]
* TLSv1.2 (IN), TLS handshake, Certificate (11):
{ [1870 bytes data]
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
{ [333 bytes data]
* TLSv1.2 (IN), TLS handshake, Request CERT (13):
{ [65 bytes data]
* TLSv1.2 (IN), TLS handshake, Server finished (14):
{ [4 bytes data]
* TLSv1.2 (OUT), TLS handshake, Certificate (11):
} [7 bytes data]
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
} [70 bytes data]
* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
} [1 bytes data]
* TLSv1.2 (OUT), TLS handshake, Finished (20):
} [16 bytes data]
* TLSv1.2 (IN), TLS change cipher, Client hello (1):
{ [1 bytes data]
* TLSv1.2 (IN), TLS handshake, Finished (20):
{ [16 bytes data]
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server accepted to use http/1.1
* Server certificate:
*        subject: CN=10.0.0.4
*        start date: Dec 20 18:25:49 2016 GMT
*        expire date: Dec 20 18:25:50 2018 GMT
*        issuer: CN=openshift-signer@1482258350
*        SSL certificate verify result: self signed certificate in certificate chain (19), continuing anyway.
* Server auth using Basic with user '[USERNAME]'
} [5 bytes data]
> GET /oauth/authorize?client_id=openshift-challenging-client&response_type=token HTTP/1.1
> Host: [MASTER-URL:PORT]
> Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
> User-Agent: curl/7.46.0
> Accept: */*
> X-Csrf-Token: 1
>
{ [5 bytes data]
< HTTP/1.1 302 Found
< Cache-Control: no-cache, no-store, max-age=0, must-revalidate
< Expires: Fri, 01 Jan 1990 00:00:00 GMT
< Location: https://[MASTER-URL:PORT]/oauth/token/implicit#access_token=XXXXXXXXXXXXXXXXXXXXxSYRmKj3J17JXYtDTejBsA&expires_in=86400&scope=user:full&token_type=Bearer
< Pragma: no-cache
< Set-Cookie: ssn=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXxFJXzVnNU9PZjVPdlFGNzRFOThNbGtRU0NsWXNGNms0VHI4WWpVbThZUEdaSThuUlJWWENsVkd6ekNpaW5DMUFBPT18puNoY1Fl6pWbzX8BpkRp-oPKTLq2_Hgvj5mGR7xk4qU=; Path=/; Expires=Fri, 06 Jan 2017 11:24:02 GMT; Max-Age=3600; HttpOnly; Secure
< Date: Fri, 06 Jan 2017 10:24:02 GMT
< Content-Length: 0
< Content-Type: text/plain; charset=utf-8
<
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
* Connection #0 to host osev3master.germanycentral.cloudapp.microsoftazure.de left intact
```

# Tenants auflisten

Tenants entspricht den OpenShift Projekten. 

[TODO] Im Request muss ein Tenant aufgeführt sein, für den der Nutzer berechtigt ist. Ggf. können dem Nutzer andere Rechte zugewiesen werden.

```bash
curl -k -X GET https://[METRICS-URL]/hawkular/metrics/tenants -H "Content-Type: application/json" -H "Hawkular-Tenant: tm2" -H "Authorization: Bearer yl49Lh5pl1Ie9ss15WJnkbSYRmKj3J17JXYtDTejBsA"
```

```bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   180  100   180    0     0    205      0 --:--:-- --:--:-- --:--:--   209[{"id":"mlbparksroadshow"},{"id":"openshift-infra"},{"id":"tm3"},{"id":"tm4"},{"id":"mlbparks1"},{"id":"management-infra"},{"id":"_system"},{"id":"ticketmonster"},{"id":"default"}]
```

# Beispielhafte Abfragen 

Quelle:

https://github.com/openshift/origin-metrics/blob/master/docs/hawkular_metrics.adoc

## Accessing all metrics for a Project

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/metrics | python -m json.tool
```

```json
[
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/request",
            "group_id": "deployment/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/limit/logs",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/limit",
            "group_id": "deployment/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/request",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/request",
            "group_id": "deployment/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "tags": {
            "descriptor_name": "cpu/request",
            "group_id": "/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/limit/Volume:builder-dockercfg-kjme4-push",
        "tags": {
            "descriptor_name": "filesystem/limit",
            "group_id": "/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "Volume:builder-dockercfg-kjme4-push",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "tags": {
            "descriptor_name": "memory/limit",
            "group_id": "/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "tags": {
            "descriptor_name": "memory/usage",
            "group_id": "/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/tx_errors_rate",
        "tags": {
            "descriptor_name": "network/tx_errors_rate",
            "group_id": "/network/tx_errors_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/request",
        "tags": {
            "descriptor_name": "memory/request",
            "group_id": "/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/available//",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/available",
            "group_id": "deployment/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/usage//",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/usage",
            "group_id": "deployment/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/usage",
            "group_id": "deployment/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/usage_rate",
        "tags": {
            "descriptor_name": "cpu/usage_rate",
            "group_id": "/cpu/usage_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults_rate",
        "tags": {
            "descriptor_name": "memory/major_page_faults_rate",
            "group_id": "/memory/major_page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "tags": {
            "descriptor_name": "memory/working_set",
            "group_id": "/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "tags": {
            "descriptor_name": "cpu/limit",
            "group_id": "/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "tags": {
            "descriptor_name": "memory/usage",
            "group_id": "/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/limit/Volume:builder-token-xm584",
        "tags": {
            "descriptor_name": "filesystem/limit",
            "group_id": "/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "Volume:builder-token-xm584",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/available/logs",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/available",
            "group_id": "deployment/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/usage/logs",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/usage",
            "group_id": "deployment/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/working_set",
            "group_id": "deployment/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/available/Volume:builder-dockercfg-kjme4-push",
        "tags": {
            "descriptor_name": "filesystem/available",
            "group_id": "/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "Volume:builder-dockercfg-kjme4-push",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/usage/Volume:builder-dockercfg-kjme4-push",
        "tags": {
            "descriptor_name": "filesystem/usage",
            "group_id": "/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "Volume:builder-dockercfg-kjme4-push",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/page_faults_rate",
        "tags": {
            "descriptor_name": "memory/page_faults_rate",
            "group_id": "/memory/page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/rx_errors_rate",
        "tags": {
            "descriptor_name": "network/rx_errors_rate",
            "group_id": "/network/rx_errors_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "tags": {
            "descriptor_name": "cpu/request",
            "group_id": "/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "tags": {
            "descriptor_name": "memory/working_set",
            "group_id": "/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "tags": {
            "descriptor_name": "memory/limit",
            "group_id": "/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/limit",
            "group_id": "deployment/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/limit//",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/limit",
            "group_id": "deployment/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/limit",
            "group_id": "deployment/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "tags": {
            "descriptor_name": "cpu/limit",
            "group_id": "/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/available/Volume:builder-token-xm584",
        "tags": {
            "descriptor_name": "filesystem/available",
            "group_id": "/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "Volume:builder-token-xm584",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/usage/Volume:builder-token-xm584",
        "tags": {
            "descriptor_name": "filesystem/usage",
            "group_id": "/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "Volume:builder-token-xm584",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/request",
        "tags": {
            "descriptor_name": "memory/request",
            "group_id": "/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/rx_rate",
        "tags": {
            "descriptor_name": "network/rx_rate",
            "group_id": "/network/rx_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/tx_rate",
        "tags": {
            "descriptor_name": "network/tx_rate",
            "group_id": "/network/tx_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "cpu/limit",
            "group_id": "/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/available/Volume:default-token-gptiv",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "filesystem/available",
            "group_id": "/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "Volume:default-token-gptiv",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/major_page_faults",
            "group_id": "deployment/memory/major_page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/rx_errors",
        "tags": {
            "descriptor_name": "network/rx_errors",
            "group_id": "/network/rx_errors",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/network/tx_errors",
        "tags": {
            "descriptor_name": "network/tx_errors",
            "group_id": "/network/tx_errors",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/page_faults",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/page_faults",
            "group_id": "sti-build/memory/page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/limit",
            "group_id": "sti-build/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/usage",
            "group_id": "sti-build/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/request",
            "group_id": "sti-build/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/limit/logs",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/limit",
            "group_id": "sti-build/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/page_faults_rate",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/page_faults_rate",
            "group_id": "sti-build/memory/page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/working_set",
            "group_id": "sti-build/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/uptime",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "uptime",
            "group_id": "deployment/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/tx_errors",
        "tags": {
            "descriptor_name": "network/tx_errors",
            "group_id": "/network/tx_errors",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/usage//",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/usage",
            "group_id": "sti-build/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/available//",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/available",
            "group_id": "sti-build/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/page_faults",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/page_faults",
            "group_id": "deployment/memory/page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/uptime",
        "tags": {
            "descriptor_name": "uptime",
            "group_id": "/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage_rate",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178410000,
        "tags": {
            "descriptor_name": "cpu/usage_rate",
            "group_id": "/cpu/usage_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/usage",
            "group_id": "sti-build/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/limit",
            "group_id": "sti-build/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/available/logs",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/available",
            "group_id": "sti-build/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults_rate",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/major_page_faults_rate",
            "group_id": "sti-build/memory/major_page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/tx",
        "tags": {
            "descriptor_name": "network/tx",
            "group_id": "/network/tx",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/limit//",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/limit",
            "group_id": "sti-build/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/uptime",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "uptime",
            "group_id": "sti-build/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/tx_errors_rate",
        "maxTimestamp": 1483791620000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/tx_errors_rate",
            "group_id": "/network/tx_errors_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/usage_rate",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/usage_rate",
            "group_id": "sti-build/cpu/usage_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/usage",
            "group_id": "deployment/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/network/tx",
        "tags": {
            "descriptor_name": "network/tx",
            "group_id": "/network/tx",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/usage/logs",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/usage",
            "group_id": "sti-build/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/request",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/request",
            "group_id": "sti-build/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/network/rx",
        "tags": {
            "descriptor_name": "network/rx",
            "group_id": "/network/rx",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "memory/limit",
            "group_id": "/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/tx_rate",
        "maxTimestamp": 1483791620000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/tx_rate",
            "group_id": "/network/tx_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/major_page_faults",
            "group_id": "sti-build/memory/major_page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/memory/page_faults_rate",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178410000,
        "tags": {
            "descriptor_name": "memory/page_faults_rate",
            "group_id": "/memory/page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/rx_errors_rate",
        "maxTimestamp": 1483791620000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/rx_errors_rate",
            "group_id": "/network/rx_errors_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/8e5a974a-c84f-11e6-a8bb-0017fa100643/uptime",
        "tags": {
            "descriptor_name": "uptime",
            "group_id": "/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/usage/Volume:default-token-gptiv",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "filesystem/usage",
            "group_id": "/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "Volume:default-token-gptiv",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/memory/request",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "memory/request",
            "group_id": "/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/network/rx",
        "tags": {
            "descriptor_name": "network/rx",
            "group_id": "/network/rx",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults_rate",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178410000,
        "tags": {
            "descriptor_name": "memory/major_page_faults_rate",
            "group_id": "/memory/major_page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/rx_rate",
        "maxTimestamp": 1483791620000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/rx_rate",
            "group_id": "/network/rx_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c6f5adad-c84f-11e6-a8bb-0017fa100643/network/rx_errors",
        "tags": {
            "descriptor_name": "network/rx_errors",
            "group_id": "/network/rx_errors",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/limit/Volume:default-token-gptiv",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "filesystem/limit",
            "group_id": "/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "Volume:default-token-gptiv",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "cpu/request",
            "group_id": "/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/uptime",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "uptime",
            "group_id": "ticket-monster/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/limit",
            "group_id": "ticket-monster/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/tx_errors",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/tx_errors",
            "group_id": "/network/tx_errors",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/rx_errors",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/rx_errors",
            "group_id": "/network/rx_errors",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/page_faults_rate",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178410000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/page_faults_rate",
            "group_id": "ticket-monster/memory/page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/working_set",
            "group_id": "ticket-monster/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/usage",
            "group_id": "ticket-monster/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/request",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/request",
            "group_id": "ticket-monster/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "memory/usage",
            "group_id": "/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults_rate",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178410000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/major_page_faults_rate",
            "group_id": "ticket-monster/memory/major_page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/usage/logs",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/usage",
            "group_id": "ticket-monster/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/available/logs",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/available",
            "group_id": "ticket-monster/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/rx",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/rx",
            "group_id": "/network/rx",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/usage//",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/usage",
            "group_id": "ticket-monster/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/usage",
            "group_id": "ticket-monster/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "memory/working_set",
            "group_id": "/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage_rate",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178410000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/usage_rate",
            "group_id": "ticket-monster/cpu/usage_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/request",
            "group_id": "ticket-monster/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/uptime",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "uptime",
            "group_id": "/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "pod/c9970194-c84f-11e6-a8bb-0017fa100643/network/tx",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "descriptor_name": "network/tx",
            "group_id": "/network/tx",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/limit//",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/limit",
            "group_id": "ticket-monster/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/limit",
            "group_id": "ticket-monster/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/page_faults",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/page_faults",
            "group_id": "ticket-monster/memory/page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/limit/logs",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/limit",
            "group_id": "ticket-monster/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/major_page_faults",
            "group_id": "ticket-monster/memory/major_page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/available//",
        "maxTimestamp": 1483791630000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/available",
            "group_id": "ticket-monster/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    }
] 
```

## Accessing Node Metrics

Die folgenden Beispiele beziehen sich auf Metriken des Nodes, nicht der Container.

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: _system" -X GET https://[METRICS-URL]/hawkular/metrics/metrics | python -m json.tool
```
	   
```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: _system" -X GET https://[METRICS-URL]/hawkular/metrics/metrics | python -m json.tool | grep -i \"id\" | grep -i machine
```
	   
## Querying based on tag

### Accessing all the cpu/usage metrics

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/metrics?tags=descriptor_name:cpu/usage | python -m json.tool
```
	   
```json
[
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/usage",
            "group_id": "deployment/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/usage",
            "group_id": "sti-build/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "maxTimestamp": 1483792200000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/usage",
            "group_id": "ticket-monster/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    }
] 
```

### Accessing all the cpu/usage metrics in pod named ticket-monster-1-o0etr

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/metrics?tags=descriptor_name:cpu/usage,pod_name:ticket-monster-1-o0etr  | python -m json.tool
```
	   
```json
[
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "maxTimestamp": 1483792340000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/usage",
            "group_id": "ticket-monster/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    }
] 
```

### Regular Expressions: Accessing all pods where the container_base_image contains ticket-monster

Regular expressions can also be used in tag queries. The following example will return all metrics where the container_base_image contains ticket-monster:

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: test" -X GET https://[METRICS-URL]/hawkular/metrics/metrics?tags=container_base_image:.*ticket-monster.*  | python -m json.tool
```

```json
[
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults_rate",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178410000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/major_page_faults_rate",
            "group_id": "ticket-monster/memory/major_page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/available/logs",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/available",
            "group_id": "ticket-monster/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/page_faults",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/page_faults",
            "group_id": "ticket-monster/memory/page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/available//",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/available",
            "group_id": "ticket-monster/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/uptime",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "uptime",
            "group_id": "ticket-monster/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/request",
            "group_id": "ticket-monster/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/limit",
            "group_id": "ticket-monster/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage_rate",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178410000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/usage_rate",
            "group_id": "ticket-monster/cpu/usage_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/limit",
            "group_id": "ticket-monster/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/usage",
            "group_id": "ticket-monster/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "cpu/usage",
            "group_id": "ticket-monster/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/working_set",
            "group_id": "ticket-monster/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/usage//",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/usage",
            "group_id": "ticket-monster/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/usage/logs",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/usage",
            "group_id": "ticket-monster/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/page_faults_rate",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178410000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/page_faults_rate",
            "group_id": "ticket-monster/memory/page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/request",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/request",
            "group_id": "ticket-monster/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/limit/logs",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/limit",
            "group_id": "ticket-monster/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "memory/major_page_faults",
            "group_id": "ticket-monster/memory/major_page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/filesystem/limit//",
        "maxTimestamp": 1483792460000,
        "minTimestamp": 1483178400000,
        "tags": {
            "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
            "container_name": "ticket-monster",
            "descriptor_name": "filesystem/limit",
            "group_id": "ticket-monster/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-o0etr",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    }
] 
```

### Regular Expressions: Accessing all pods where the container_base_image start with openshift/

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/metrics?tags=container_base_image:openshift/.*  | python -m json.tool
```
	   
```json
[
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/available//",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/available",
            "group_id": "deployment/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/page_faults",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/page_faults",
            "group_id": "deployment/memory/page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults_rate",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/major_page_faults_rate",
            "group_id": "sti-build/memory/major_page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/uptime",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "uptime",
            "group_id": "deployment/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/working_set",
            "group_id": "sti-build/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/major_page_faults",
            "group_id": "sti-build/memory/major_page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/usage",
            "group_id": "sti-build/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/limit//",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/limit",
            "group_id": "deployment/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/major_page_faults",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/major_page_faults",
            "group_id": "deployment/memory/major_page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/limit//",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/limit",
            "group_id": "sti-build/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/limit/logs",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/limit",
            "group_id": "deployment/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/usage/logs",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/usage",
            "group_id": "sti-build/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/limit/logs",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/limit",
            "group_id": "sti-build/filesystem/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/request",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/request",
            "group_id": "sti-build/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/working_set",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/working_set",
            "group_id": "deployment/memory/working_set",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/available/logs",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/available",
            "group_id": "sti-build/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/limit",
            "group_id": "sti-build/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/uptime",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "uptime",
            "group_id": "sti-build/uptime",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ms"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/usage",
            "group_id": "deployment/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/request",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/request",
            "group_id": "deployment/memory/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/page_faults_rate",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/page_faults_rate",
            "group_id": "sti-build/memory/page_faults_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/usage/logs",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/usage",
            "group_id": "deployment/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/available/logs",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/available",
            "group_id": "deployment/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "logs",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/usage_rate",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/usage_rate",
            "group_id": "sti-build/cpu/usage_rate",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/limit",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/limit",
            "group_id": "deployment/cpu/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/limit",
            "group_id": "deployment/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/usage//",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/usage",
            "group_id": "sti-build/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/request",
            "group_id": "sti-build/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/memory/usage",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "memory/usage",
            "group_id": "deployment/memory/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/filesystem/usage//",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "filesystem/usage",
            "group_id": "deployment/filesystem/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/limit",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/limit",
            "group_id": "sti-build/memory/limit",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "deployment/c6f5adad-c84f-11e6-a8bb-0017fa100643/cpu/request",
        "tags": {
            "container_base_image": "openshift/origin-deployer:v1.3.1",
            "container_name": "deployment",
            "descriptor_name": "cpu/request",
            "group_id": "deployment/cpu/request",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/deployer-pod-for.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "c6f5adad-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-deploy",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/filesystem/available//",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "filesystem/available",
            "group_id": "sti-build/filesystem/available",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "resource_id": "/",
            "resource_id_description": "Identifier(s) specific to a metric",
            "type": "pod_container",
            "units": "bytes"
        },
        "tenantId": "tm3",
        "type": "gauge"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/memory/page_faults",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "memory/page_faults",
            "group_id": "sti-build/memory/page_faults",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container"
        },
        "tenantId": "tm3",
        "type": "counter"
    },
    {
        "dataRetention": 7,
        "id": "sti-build/8e5a974a-c84f-11e6-a8bb-0017fa100643/cpu/usage",
        "tags": {
            "container_base_image": "openshift/origin-sti-builder:v1.3.1",
            "container_name": "sti-build",
            "descriptor_name": "cpu/usage",
            "group_id": "sti-build/cpu/usage",
            "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "labels": "openshift.io/build.name:ticket-monster-1",
            "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
            "namespace_name": "tm3",
            "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
            "pod_id": "8e5a974a-c84f-11e6-a8bb-0017fa100643",
            "pod_name": "ticket-monster-1-build",
            "pod_namespace": "tm3",
            "type": "pod_container",
            "units": "ns"
        },
        "tenantId": "tm3",
        "type": "counter"
    }
] 
```

## Accessing A Specific Metric

ID für die Tests: ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage

### Accessing the counter metric with id 'ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage'

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/counters/ticket-monster%2Fc9970194-c84f-11e6-a8bb-0017fa100643%2Fcpu%2Fusage  | python -m json.tool
```

```json
{
    "dataRetention": 7,
    "id": "ticket-monster/c9970194-c84f-11e6-a8bb-0017fa100643/cpu/usage",
    "maxTimestamp": 1483792850000,
    "minTimestamp": 1483178400000,
    "tags": {
        "container_base_image": "172.30.19.165:5000/tm3/ticket-monster@sha256:f39c8d2fc5bb4789070ea42643b43360d85b72346977afac58f4d9adf06cda4d",
        "container_name": "ticket-monster",
        "descriptor_name": "cpu/usage",
        "group_id": "ticket-monster/cpu/usage",
        "host_id": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
        "hostname": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
        "labels": "app:ticket-monster,deployment:ticket-monster-1,deploymentConfig:ticket-monster,deploymentconfig:ticket-monster",
        "namespace_id": "38760c8b-c84f-11e6-a8bb-0017fa100643",
        "namespace_name": "tm3",
        "nodename": "node-0.3by10k14c3se1ndfrstixsogub.ax.internal.azurecloudapp.de",
        "pod_id": "c9970194-c84f-11e6-a8bb-0017fa100643",
        "pod_name": "ticket-monster-1-o0etr",
        "pod_namespace": "tm3",
        "type": "pod_container",
        "units": "ns"
    },
    "tenantId": "tm3",
    "type": "counter"
} 
```

### Accessing the metric data for a counter metric with id 'ticket-monster%2Fc9970194-c84f-11e6-a8bb-0017fa100643%2Fcpu%2Fusage' 

The following command will return the data for the metric for the last 10 minutes, placed into 5 buckets of 2 minutes each.

Note: date -d -10minutes +%s%3N will return a start time 10 minutes ago in milliseconds

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/counters/ticket-monster%2Fc9970194-c84f-11e6-a8bb-0017fa100643%2Fcpu%2Fusage/data?buckets=5\&start=`date -d -10minutes +%s%3N`  | python -m json.tool
```

```json
[
    {
        "avg": 1267095772768.25,
        "empty": false,
        "end": 1483792532810,
        "max": 1267133336743.0,
        "median": 1267085626409.7083,
        "min": 1267054696634.0,
        "samples": 12,
        "start": 1483792415360,
        "sum": 15205149273219.0
    },
    {
        "avg": 1267198704828.3333,
        "empty": false,
        "end": 1483792650260,
        "max": 1267241380683.0,
        "median": 1267197431126.709,
        "min": 1267148659250.0,
        "samples": 12,
        "start": 1483792532810,
        "sum": 15206384457940.0
    },
    {
        "avg": 1267298569161.091,
        "empty": false,
        "end": 1483792767710,
        "max": 1267351201919.0,
        "median": 1267304775390.6968,
        "min": 1267252170639.0,
        "samples": 11,
        "start": 1483792650260,
        "sum": 13940284260772.0
    },
    {
        "avg": 1267403004683.0002,
        "empty": false,
        "end": 1483792885160,
        "max": 1267447961564.0,
        "median": 1267404529120.4717,
        "min": 1267361585692.0,
        "samples": 12,
        "start": 1483792767710,
        "sum": 15208836056196.0
    },
    {
        "avg": 1267495180903.0908,
        "empty": false,
        "end": 1483793002610,
        "max": 1267545386894.0,
        "median": 1267487412594.2603,
        "min": 1267458292941.0,
        "samples": 11,
        "start": 1483792885160,
        "sum": 13942446989934.0
    }
] 
```

### Accessing the metric rate data for a counter metric with id 'ticket-monster%2Fc9970194-c84f-11e6-a8bb-0017fa100643%2Fcpu%2Fusage' 

The following command is the same as the previous one, but it return rate data instead of the raw data. Where the rate data is a delta between the previous values and not the absolute value.

This is useful for graphing cpu usage data as it gives you the usage between two points in time and not the absolute usage since the start of the container.

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/counters/ticket-monster%2Fc9970194-c84f-11e6-a8bb-0017fa100643%2Fcpu%2Fusage/rate?buckets=5\&start=`date -d -10minutes +%s%3N`  | python -m json.tool
```

```json
[
    {
        "avg": 48777690.6,
        "empty": false,
        "end": 1483792609329,
        "max": 100920030.0,
        "median": 70225620.0,
        "min": 0.0,
        "samples": 10,
        "start": 1483792491887,
        "sum": 487776906.0
    },
    {
        "avg": 49903890.5,
        "empty": false,
        "end": 1483792726771,
        "max": 130987812.0,
        "median": 60153717.0,
        "min": 0.0,
        "samples": 12,
        "start": 1483792609329,
        "sum": 598846686.0
    },
    {
        "avg": 55409599.0,
        "empty": false,
        "end": 1483792844213,
        "max": 108500214.0,
        "median": 69146424.33333333,
        "min": 0.0,
        "samples": 12,
        "start": 1483792726771,
        "sum": 664915188.0
    },
    {
        "avg": 52328548.00000001,
        "empty": false,
        "end": 1483792961655,
        "max": 122574072.0,
        "median": 58934754.0,
        "min": 0.0,
        "samples": 12,
        "start": 1483792844213,
        "sum": 627942576.0
    },
    {
        "avg": 54040862.18181819,
        "empty": false,
        "end": 1483793079097,
        "max": 109423704.0,
        "median": 69324099.25,
        "min": 0.0,
        "samples": 11,
        "start": 1483792961655,
        "sum": 594449484.0
    }
] 
```

## Consolidating Metric Data Across Multiple Containers

### Determining the average CPU usage across multiple pods

For the following example, we want to determine what the average cpu usage is for all containers within the 'tm3' project.

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/counters/data?tags=descriptor_name:cpu/usage,pod_namespace:tm3\&buckets=3\&start=`date -d -10minutes +%s%3N`  | python -m json.tool
```

```json
[
    {
        "avg": 1267330815773.5,
        "empty": false,
        "end": 1483792843307,
        "max": 1267413051888.0,
        "median": 1267325928335.4185,
        "min": 1267241380683.0,
        "samples": 20,
        "start": 1483792647641,
        "sum": 25346616315470.0
    },
    {
        "avg": 1267497082632.7896,
        "empty": false,
        "end": 1483793038973,
        "max": 1267579562658.0,
        "median": 1267490583777.4355,
        "min": 1267429199386.0,
        "samples": 19,
        "start": 1483792843307,
        "sum": 24082444570023.0
    },
    {
        "avg": 1267671121908.1052,
        "empty": false,
        "end": 1483793234639,
        "max": 1267762028877.0,
        "median": 1267676461300.4033,
        "min": 1267593434197.0,
        "samples": 19,
        "start": 1483793038973,
        "sum": 24085751316254.0
    }
] 
```

### Get the CPU usage for all containers in a pod

Metric data is stored per individual containers, but you may want to get metric data based on pods instead of containers.

The following example shows how to get the cpu/usage metric for all containers within a pod named myPod.

Note that since we are looking for the overall usage of a pod, and not just the average usage, then we cannot use something like previous example. For this we need to use the stacked option which will perform individual queries on the tags requested and then add the resulting buckets together.

So if the tag query matches two metrics and the average value for the bucket of the first metric is 5 and the average value of the second bucket is 10, then with stacked=true the bucket returned will be 10.

```bash
curl -k -H "Authorization: Bearer [TOKEN]" -H "Hawkular-Tenant: tm3" -X GET https://[METRICS-URL]/hawkular/metrics/counters/data?tags=descriptor_name:cpu/usage,pod_name:ticket-monster-1-o0etr\&stacked=true\&buckets=3\&start=`date -d -10minutes +%s%3N`  | python -m json.tool
```

```json
[
    {
        "avg": 1267638096212.2498,
        "empty": false,
        "end": 1483793192945,
        "max": 1267728610886.0,
        "median": 1267655633438.4758,
        "min": 1267545386894.0,
        "samples": 1,
        "start": 1483792997083,
        "sum": 25352761924245.0
    },
    {
        "avg": 1267819188286.1577,
        "empty": false,
        "end": 1483793388807,
        "max": 1267894051434.0,
        "median": 1267805221926.377,
        "min": 1267728610886.0,
        "samples": 1,
        "start": 1483793192945,
        "sum": 24088564577437.0
    },
    {
        "avg": 1267987740526.0525,
        "empty": false,
        "end": 1483793584669,
        "max": 1268071361574.0,
        "median": 1267982846038.9158,
        "min": 1267909765740.0,
        "samples": 1,
        "start": 1483793388807,
        "sum": 24091767069995.0
    }
] 
```

# Offene Fragen

* Abfrage der Daten bei/nach Container-Restart
* Umrechnung der Daten

 
