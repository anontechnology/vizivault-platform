# ViziVault Platform

## TL;DR

```
$ helm install my-release anontech/vizivault
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
$ helm install my-release anontech/vizivault
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
| `global.pullSecrets` | Global Docker registry secret names as an array | `[]` (does not add image pull secrets to deployed pods) |
| `global.storageClass`     | Global storage class for dynamic provisioning   | `nil`                                                   |

### Common Parameters

| Parameter                             | Description                                                                                                                                                                                    | Default                                                 |
|---------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `commonLabels`                        | Labels to add to all deployed objects                                                                                                                                                          | `nil`                                                   |
| `commonAnnotations`                   | Annotations to add to all deployed objects                                                                                                                                                     | `[]`                                                    |
| `kubeVersion`                         | Force target Kubernetes version (using Helm capabilities if not set)                                                                                                                           | `nil`                                                   |
| `containerSecurityContext`            | Container security podSecurityContext                                                                                                                                                          | `{ runAsUser: 1001, runAsNonRoot: true }`               |
| `podSecurityContext`                  | Pod security context                                                                                                                                                                           | `{ fsGroup: 1001 }`                                     |
| `volumePermissions.enabled`           | Enable init container that changes volume permissions in the data directory (for cases where the default k8s `runAsUser` and `fsUser` values do not work)                                      | `false`                                                 |

### External Access Parameters

| Parameter                  | Description                                                           | Default                   |
|----------------------------|-----------------------------------------------------------------------|---------------------------|
| ingress.web.enabled        | Enables the ingress for the ViziVault web application (public access) | false                     |
| ingress.web.domain         | The domain that the ingress uses for the host values                  | vizivault.anontech.domain |
| ingress.web.annotations    | Annotations used in the ingress resource                              | {}                        |
| ingress.web.tls.enabled    | Enables or disables TLS on the Ingress resource                       | false                     |
| ingress.web.tls.secretName | Points to the existing secret name that contains the SSL certificates | nil                       |
| ingress.api.enabled        | Enables the ingress for the ViziVault REST API (public access)        | false                     |
| ingress.api.domain         | The domain that the ingress uses for the host values                  | api.anontech.domain       |
| ingress.api.annotations    | Annotations used in the ingress resource                              | {}                        |
| ingress.api.tls.enabled    | Enables or disables TLS on the Ingress resource                       | false                     |
| ingress.api.tls.secretName | Points to the existing secret name that contains the SSL certificates | nil                       |

### ViziVault Parameters

### REST API Parameters

### Alerting Parameters

### Crypto Parameters


### Authorization Parameters