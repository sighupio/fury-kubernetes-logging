<h1>
    <img src="https://github.com/sighupio/fury-distribution/blob/main/docs/assets/fury-epta-white.png?raw=true" align="left" width="90" style="margin-right: 15px"/>
    Kubernetes Fury Logging
</h1>

![Release](https://img.shields.io/badge/Latest%20Release-v3.2.0-blue)
![License](https://img.shields.io/github/license/sighupio/fury-kubernetes-logging?label=License)
![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack&label=Slack)

<!-- <KFD-DOCS> -->

**Kubernetes Fury Logging** provides a logging stack for the [Kubernetes Fury Distribution (KFD)][kfd-repo].

If you are new to KFD please refer to the [official documentation][kfd-docs] on how to get started with KFD.

## Overview

**Kubernetes Fury Logging** uses a collection of open source tools to provide the most resilient and robust logging stack for the cluster.

The central piece of the stack is the open source search engine [opensearch][opensearch-page], combined
with its analytics and visualization platform [opensearch-dashboards][opensearch-dashboards-page].
The logs are collected using a node-level data collection and enrichment agent [fluentbit][fluentbit-page],
pushing it to the OpenSearch via [fluentd][fluentd-page]. The fluentbit and fluentd stack is managed by Banzai Logging Operator.
We are also providing an alternative to OpenSearch: [loki][loki-page].

All the components are deployed in the `logging` namespace in the cluster.

High level diagram of the stack:

![logging module](docs/images/diagram.png "Kubernetes Fury Logging")

## Packages

The following packages are included in the Fury Kubernetes Logging katalog:

| Package                                                | Version                         | Description                                                                                 |
| ------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------------------------------------- |
| [cerebro](katalog/cerebro)                             | `0.9.4`                         | Web admin tool that helps you manage your Opensearch cluster via a graphical user interface |
| [opensearch-single](katalog/opensearch-single)         | `2.5.0`                         | Single node opensearch deployment. Not intended for production use.                         |
| [opensearch-triple](katalog/opensearch-triple)         | `2.5.0`                         | Three node high-availability opensearch deployment                                          |
| [opensearch-dashboards](katalog/opensearch-dashboards) | `2.5.0`                         | Analytics and visualization platform for Opensearch                                         |
| [logging-operator](katalog/logging-operator)           | `4.1.0`                         | Banzai logging operator, manages fluentbit/fluentd and their configurations                 |
| [logging-operated](katalog/logging-operated)           | `-`                             | fluentd and fluentbit deployment using logging operator                                     |
| [configs](katalog/configs)                             | `-`                             | Logging pipeline configs to gather various types of logs and send them to OpenSearch        |
| [loki-configs](katalog/loki-configs)                   | `-`                             | Logging pipeline configs to gather various types of logs and send them to Loki              |
| [loki-distributed](katalog/loki-distributed)           | `2.7.3`                         | Distributed Loki deployment                                                                 |
| [minio-ha](katalog/minio-ha)                           | `vRELEASE.2023-01-12T02-06-16Z` | Three nodes HA MinIO deployment                                                             |

Click on each package to see its full documentation.

## Compatibility

| Kubernetes Version |   Compatibility    | Notes           |
| ------------------ | :----------------: | --------------- |
| `1.24.x`           | :white_check_mark: | No known issues |
| `1.25.x`           | :white_check_mark: | No known issues |
| `1.26.x`           | :white_check_mark: | No known issues |

Check the [compatibility matrix][compatibility-matrix] for additional informations about previous releases of the modules.

## Usage

### Prerequisites

| Tool                        | Version   | Description                                                                                                                                                    |
| --------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [furyctl][furyctl-repo]     | `>=0.6.0` | The recommended tool to download and manage KFD modules and their packages. To learn more about `furyctl` read the [official documentation][furyctl-repo].     |
| [kustomize][kustomize-repo] | `>=3.5.0` | Packages are customized using `kustomize`. To learn how to create your customization layer with `kustomize`, please refer to the [repository][kustomize-repo]. |

### Deployment with OpenSearch

1. List the packages you want to deploy and their version in a `Furyfile.yml`

```yaml
bases:
  - name: logging/cerebro
    version: "v3.2.0"
  - name: logging/opensearch-single
    version: "v3.2.0"
  - name: logging/opensearch-dashboards
    version: "v3.2.0"
  - name: logging/logging-operator
    version: "v3.2.0"
  - name: logging/logging-operated
    version: "v3.2.0"
  - name: minio/minio-ha
    version: "v3.2.0"
  - name: logging/configs
    version: "v3.2.0"
```

> See `furyctl` [documentation][furyctl-repo] for additional details about `Furyfile.yml` format.

2. Execute `furyctl vendor -H` to download the packages

3. Inspect the download packages under `./vendor/katalog/logging`.

4. Define a `kustomization.yaml` that includes the `./vendor/katalog/logging` directory as resource.

```yaml
resources:
- ./vendor/katalog/logging/cerebro
- ./vendor/katalog/logging/opensearch-single
- ./vendor/katalog/logging/opensearch-dashboards
- ./vendor/katalog/logging/logging-operator
- ./vendor/katalog/logging/logging-operated
- ./vendor/katalog/logging/minio-ha
- ./vendor/katalog/logging/configs
``

5. To deploy the packages to your cluster, execute:

```bash
kustomize build . | kubectl apply -f -
```

> Note: When installing the packages, you need to ensure that the Prometheus operator is also installed.
> Otherwise, the API server will reject all ServiceMonitor resources.

### Deployment with Loki

1. List the packages you want to deploy and their version in a `Furyfile.yml`

```yaml
bases:
  - name: logging/loki-distributed
    version: "v3.2.0"
  - name: logging/logging-operator
    version: "v3.2.0"
  - name: logging/logging-operated
    version: "v3.2.0"
  - name: minio/minio-ha
    version: "v3.2.0"
  - name: logging/configs
    version: "v3.2.0"
  - name: logging/loki-configs
    version: "v3.2.0"
```

> See `furyctl` [documentation][furyctl-repo] for additional details about `Furyfile.yml` format.

2. Execute `furyctl vendor -H` to download the packages

3. Inspect the download packages under `./vendor/katalog/logging`.

4. Define a `kustomization.yaml` that includes the `./vendor/katalog/logging` directory as resource.

```yaml
resources:
- ./vendor/katalog/logging/loki-distributed
- ./vendor/katalog/logging/logging-operator
- ./vendor/katalog/logging/logging-operated
- ./vendor/katalog/logging/minio-ha
- ./vendor/katalog/logging/loki-configs
``

5. To deploy the packages to your cluster, execute:

```bash
kustomize build . | kubectl apply -f -
```

> Note: When installing the packages, you need to ensure that the Prometheus operator is also installed.
> Otherwise, the API server will reject all ServiceMonitor resources.

### Common Customisations

#### Setup a high-availability three-node OpenSearch

Logging module offers an out of the box, highly-available setup for `opensearch` instead of a single node version. To set this up, in the `Furyfile` and `kustomization`, you can replace `opensearch-single` with `opensearch-triple`.

#### Configure tolerations and node selectors

If you need to specify tolerations and/or node selectors, you can find some snippets in [examples/tolerations](examples/tolerations) and its subfolders.

<!-- Links -->

[opensearch-page]: https://opensearch.org
[opensearch-dashboards-page]: https://opensearch.org
[fluentbit-page]: https://fluentbit.io/
[fluentd-page]: https://www.fluentd.org/
[loki-page]: https://grafana.com/oss/loki/
[kfd-repo]: https://github.com/sighupio/fury-distribution
[furyctl-repo]: https://github.com/sighupio/furyctl
[kustomize-repo]: https://github.com/kubernetes-sigs/kustomize
[kfd-docs]: https://docs.kubernetesfury.com/docs/distribution/
[compatibility-matrix]: https://github.com/sighupio/fury-kubernetes-logging/blob/master/docs/COMPATIBILITY_MATRIX.md

<!-- </KFD-DOCS> -->

<!-- <FOOTER> -->

## Contributing

Before contributing, please read first the [Contributing Guidelines](docs/CONTRIBUTING.md).

### Reporting Issues

In case you experience any problems with the module, please [open a new issue](https://github.com/sighupio/fury-kubernetes-logging/issues/new/choose).

## License

This module is open-source and it's released under the following [LICENSE](LICENSE)

<!-- </FOOTER> -->
