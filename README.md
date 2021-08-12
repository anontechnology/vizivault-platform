# ViziVault Platform

Manage personal information (PI) as-a-service safely, securely, and in compliance with data privacy regulations using ViziVault.

## TL;DR

```
$ helm install my-release anontech/vizivault-platform
```

## Introduction

This [Helm](https://github.com/kubernetes/helm) chart installs the [ViziVault Platform](https://docs.anontech.io/) in a Kubernetes cluster.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

Install the chart with the release name `my-release`:

```bash
$ helm install my-release anontech/vizivault-platform
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

Additionally, if `persistence.resourcePolicy` is set to `keep`, you should manually delete the PVCs.

## Parameters

The following tables list the configurable parameters for the ViziVault Platform chart and their default values per section/component:

### Global Parameters

| Parameter                 | Description                                     | Default                                                 |
|---------------------------|-------------------------------------------------|---------------------------------------------------------|
| `global.registry`    | Global Docker image registry                    | `nil`                                                   |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |
| `global.storageClass`     | Global storage class for dynamic provisioning   | `nil`                                                   |
| `initializer.image.repository` | Repository for the Initializer image                 | `anontech/initializer`                 |
| `initializer.image.tag`        | Tag for the Initializer image                        | `{TAG_NAME}`                   |
| `initializer.image.pullPolicy` | Pull policy for the Initializer image                | `IfNotPresent`                 |

### Common Parameters

| Parameter                             | Description                                                                                                                                                                                    | Default                                                 |
|---------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `commonLabels`                        | Labels to add to all deployed objects                                                                                                                                                          | `nil`                                                   |
| `commonAnnotations`                   | Annotations to add to all deployed objects                                                                                                                                                     | `[]`                                                    |
| `kubeVersion`                         | Force target Kubernetes version (using Helm capabilities if not set)                                                                                                                           | `nil`                                                   |
| `containerSecurityContext`            | Container security podSecurityContext                                                                                                                                                          | `{ runAsUser: 1001, runAsNonRoot: true }`               |
| `podSecurityContext`                  | Pod security context                                                                                                                                                                           | `{ fsGroup: 1001 }`                                     |
| `volumePermissions.enabled`           | Enable init container that changes volume permissions in the data directory (for cases where the default k8s `runAsUser` and `fsUser` values do not work)                                      | `false`                                                 |
| `vizivault.admin.username` | The username to be created for the ViziVault admin account   | `vizivault`                                    |
| `vizivault.admin.password` | The password to be set for the ViziVault admin account       | _random 10 character long alphanumeric string_ |
| `vizivault.admin.email`    | The e-mail address to be set for the ViziVault admin account | `admin.anontech.domain`                        |
| `vizivault.admin.name`     | The full name to be used for the ViziVault admin account     | `ViziVault Admin`                              |


### External Access Parameters

| Parameter                    | Description                                                           | Default                     |
|------------------------------|-----------------------------------------------------------------------|-----------------------------|
| `ingress.web.enabled`        | Enables the ingress for the ViziVault web application (public access) | `false`                     |
| `ingress.web.domain`         | The domain that the ingress uses for the host values                  | `vizivault.anontech.domain` |
| `ingress.web.annotations`    | Annotations used in the ingress resource                              | `{}`                        |
| `ingress.web.tls.enabled`    | Enables or disables TLS on the Ingress resource                       | `false`                     |
| `ingress.web.tls.secretName` | Points to the existing secret name that contains the SSL certificates | `nil`                       |
| `ingress.api.enabled`        | Enables the ingress for the ViziVault REST API (public access)        | `false`                     |
| `ingress.api.domain`         | The domain that the ingress uses for the host values                  | `api.anontech.domain`       |
| `ingress.api.annotations`    | Annotations used in the ingress resource                              | `{}`                        |
| `ingress.api.tls.enabled`    | Enables or disables TLS on the Ingress resource                       | `false`                     |
| `ingress.api.tls.secretName` | Points to the existing secret name that contains the SSL certificates | `nil`                       |

### ViziVault Parameters
| Parameter                      | Description                                                  | Default                                        |
|--------------------------------|--------------------------------------------------------------|------------------------------------------------|
| `vizivault.admin.username`     | The username to be created for the ViziVault admin account   | `vizivault`                                    |
| `vizivault.admin.password`     | The password to be set for the ViziVault admin account       | _random 10 character long alphanumeric string_ |
| `vizivault.admin.email`        | The e-mail address to be set for the ViziVault admin account | `admin.anontech.domain`                        |
| `vizivault.admin.name`         | The full name to be used for the ViziVault admin account     | `ViziVault Admin`                              |
| `vizivault.oauth.enabled`      | Chooses whether or not to enable OAuth2 authentication       | `false`                                        |
| `vizivault.oauth.issuer`       | The issuer URL for OAuth2                                     | `undefined`                                    |
| `vizivault.oauth.provider`     | The OAuth2 provider name                                     | `undefined`                                    |
| `vizivault.oauth.clientId`     | The OAuth2 client ID                                         | `undefined`                                    |
| `vizivault.oauth.clientSecret` | The OAuth2 client secret                                     | `undefined`                                    |
| `vizivault.resources`          | The resources to allocate for the deployment                 | `undefined`                                    |
| `vizivault.affinity`           | Affinity for pod assignment                                  | `{} (evaluated as a template)`                 |
| `vizivault.nodeSelector`       | Node labels for pod assignment                               | `{} (evaluated as a template)`                 |
| `vizivault.tolerations`        | Tolerations for pod assignment                               | `[] (evaluated as a template)`                 |
| `vizivault.image.repository`   | Repository for the ViziVault image                           | `anontech/vault-enterprise`                    |
| `vizivault.image.tag`          | Tag for the ViziVault image                                  | `{TAG_NAME}`                                   |
| `vizivault.image.pullPolicy`   | Pull policy for the ViziVault image                          | `IfNotPresent`                                 |

### Vault API Parameters
| Parameter              | Description                                  | Default                        |
|------------------------|----------------------------------------------|--------------------------------|
| `api.name`             | The name of the API deployment               | `api`                          |
| `api.replicas`         | The number of replicas for the API           | `1`                            |
| `api.image.repository` | Repository for the API image                 | `anontech/nox`                 |
| `api.image.tag`        | Tag for the API image                        | `{TAG_NAME}`                   |
| `api.image.pullPolicy` | Pull policy for the API image                | `IfNotPresent`                 |
| `api.resources`        | The resources to allocate for the deployment | `undefined`                    |
| `api.affinity`         | Affinity for pod assignment                  | `{}` (evaluated as a template) |
| `api.nodeSelector`     | Node labels for pod assignment               | `{}` (evaluated as a template) |
| `api.tolerations`      | Tolerations for pod assignment               | `[]` (evaluated as a template) |

### Alerting Parameters
| Parameter                 | Description                                  | Default                        |
|---------------------------|----------------------------------------------|--------------------------------|
| `alerts.name`             | The name of the Alerts deployment            | `alerts`                       |
| `alerts.image.repository` | Repository for the Alerts image              | `anontech/nova`                |
| `alerts.image.tag`        | Tag for the Alerts image                     | `{TAG_NAME}`                   |
| `alerts.image.pullPolicy` | Pull policy for the Alerts image             | `IfNotPresent`                 |
| `alerts.resources`        | The resources to allocate for the deployment | `undefined`                    |
| `alerts.affinity`         | Affinity for pod assignment                  | `{}` (evaluated as a template) |
| `alerts.nodeSelector`     | Node labels for pod assignment               | `{}` (evaluated as a template) |
| `alerts.tolerations`      | Tolerations for pod assignment               | `[]` (evaluated as a template) |

### Crypto Parameters
| Parameter                 | Description                                  | Default                        |
|---------------------------|----------------------------------------------|--------------------------------|
| `cipher.name`             | The name of the Cipher deployment            | `cipher`                       |
| `cipher.image.repository` | Repository for the Cipher image              | `anontech/cipher`                |
| `cipher.image.tag`        | Tag for the Cipher image                     | `{TAG_NAME}`                   |
| `cipher.image.pullPolicy` | Pull policy for the Cipher image             | `IfNotPresent`                 |
| `cipher.resources`        | The resources to allocate for the deployment | `undefined`                    |
| `cipher.affinity`         | Affinity for pod assignment                  | `{}` (evaluated as a template) |
| `cipher.nodeSelector`     | Node labels for pod assignment               | `{}` (evaluated as a template) |
| `cipher.tolerations`      | Tolerations for pod assignment               | `[]` (evaluated as a template) |

### Authorization Parameters
| Parameter                  | Description                                  | Default                        |
|----------------------------|----------------------------------------------|--------------------------------|
| `arbiter.name`             | The name of the Arbiter deployment           | `arbiter`                      |
| `arbiter.image.repository` | Repository for the Arbiter image             | `anontech/arbiter`             |
| `arbiter.image.tag`        | Tag for the Arbiter image                    | `{TAG_NAME}`                   |
| `arbiter.image.pullPolicy` | Pull policy for the Arbiter image            | `IfNotPresent`                 |
| `arbiter.resources`        | The resources to allocate for the deployment | `undefined`                    |
| `arbiter.affinity`         | Affinity for pod assignment                  | `{}` (evaluated as a template) |
| `arbiter.nodeSelector`     | Node labels for pod assignment               | `{}` (evaluated as a template) |
| `arbiter.tolerations`      | Tolerations for pod assignment               | `[]` (evaluated as a template) |

### Database Parameters

**NOTE:** If `mongodb.enabled` is `true` then the external database values under `database.*` will be ignored

| Parameter                        | Description                                   | Default                                        |
|----------------------------------|-----------------------------------------------|------------------------------------------------|
| `mongodb.enabled`                | Enables the deployment of the MongoDB chart   | `true`                                         |
| `mongodb.architecture`           | MongoDB® architecture                          | `standalone`                                   |
| `mongodb.useStatefulSet`         | MongoDB® to use a StatefulSet deployment       | `true`                                         |
| `mongodb.auth.database`          | Database to create the custom user            | `admin`                                        |
| `mongodb.auth.username`          | Custom username to create                     | `vizivault-platform`                           |
| `mongodb.initdbScriptsConfigMap` | ConfigMap with a MongoDB® init scripts         | `vizivault-platform-initdb`                    |
| `database.authDb`                | Authentication database for the user          | `admin`                                        |
| `database.username`              | Username to connect to the Mongo cluster      | `vizivault-platform`                           |
| `database.password`              | Password used to connect to the Mongo cluster | _random 10 character long alphanumeric string_ |
| `database.host`                  | Hostname used to connect to the Mongo cluster | `localhost`                                    |
| `database.port`                  | Port used to connect to the Mongo cluster     | `27017`                                        |

For additional configuration of the MongoDB® Chart, see the [MongoDB® Helm Chart](https://github.com/bitnami/charts/tree/master/bitnami/mongodb)

### RabbitMQ Parameters

**NOTE:** If `rabbitmq.enabled` is `true` then the external RabbitMQ values under `rabbit.*` will be ignored

| Parameter                | Description                                  | Default                                        |
|--------------------------|----------------------------------------------|------------------------------------------------|
| `rabbitmq.enabled`       | Enables the deployment of the RabbitMQ chart | `true`                                         |
| `rabbitmq.auth.username` | Username to connect to the RabbitMQ instance | `vizivault-platform`                           |
| `rabbit.username`        | Username to connect to the RabbitMQ instance | `user`                                         |
| `rabbit.password`        | Password to connect to the RabbitMQ instance | _random 10 character long alphanumeric string_ |
| `rabbit.host`            | Hostname to connect to the RabbitMQ instance | `rabbitmq.local`                               |
| `rabbit.port`            | Port to connect to the RabbitMQ instance     | `5672`                                         |
| `rabbit.virtualHost`     | Virtual host to use on the RabbitMQ instance | `/`                                            |

For additional configuration of the RabbitMQ Chart, see the [RabbitMQ Helm Chart](https://github.com/bitnami/charts/tree/master/bitnami/rabbitmq)

## Configuration

### Exposing the API / Web App

#### Choosing a Method to Expose Services:
- **Ingress**: The ingress controller must be installed in the Kubernetes cluster.
- **ClusterIP**: Exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster.
- **NodePort**: Exposes the service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort service, from outside the cluster, by requesting NodeIP:NodePort.

## Troubleshooting

### MongoDB / RabbitMQ Credentials are Failing
If you are using the included MongoDB and/or RabbitMQ charts and have recently reinstalled the platform, you may be receiving authentication errors when the services boot.

This is a common issue with StatefulSets where the PVCs (Persistent Volume Claims) and associated PVs (Persistent Volumes) are not cleaned up after uninstalling a release.

To resolve the issue, you must remove the existing PVCs before installing the chart again.

For more information, please see [Persistence Volumes (PVs) Retained From Previous Releases](https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues/#persistence-volumes-pvs-retained-from-previous-releases)