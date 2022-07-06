<h1>
    <img src="https://github.com/sighupio/fury-distribution/blob/master/docs/assets/fury-epta-white.png?raw=true" align="left" width="90" style="margin-right: 15px"/>
    Kubernetes Fury Logging
</h1>

![Release](https://img.shields.io/badge/Latest%20Release-v3.0.0-blue)
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

All the components are deployed in the `logging` namespace in the cluster.

## Packages

The following packages are included in the Fury Kubernetes Logging katalog:

| Package                                                | Version  | Description                                                                                             |
|--------------------------------------------------------|----------|---------------------------------------------------------------------------------------------------------|
| [cerebro](katalog/cerebro)                             | `0.9.4`  | Web admin tool that helps you manage your Opensearch cluster via a graphical user interface             |
| [opensearch-single](katalog/opensearch-single)         | `2.0.0`  | Single node opensearch deployment. Not intended for production use.                                     |
| [opensearch-triple](katalog/opensearch-triple)         | `2.0.0`  | Three node high-availability opensearch deployment                                                      |
| [opensearch-dashboards](katalog/opensearch-dashboards) | `2.0.0`  | Analytics and visualization platform for Opensearch                                                     |
| [logging-operator](katalog/logging-operator)           | `3.17.6` | Banzai logging operator, manages fluentbit/fluentd and their configurations                             |
| [logging-operated](katalog/logging-operated)           | `-`      | fluentd and fluentbit deployment using logging operator                                                 |
| [configs](katalog/configs)                             | `-`      | Logging pipeline configs to gather various types of logs and send them to OpenSearch                    |
| [loki-configs](katalog/loki-configs)                   | `-`      | Logging pipeline configs to gather various types of logs and send them to Loki                          |
| [loki-single](katalog/loki-single)                     | `2.4.2`  | Single node Loki deployment                                                                             |

Click on each package to see its full documentation.

## Compatibility

| Kubernetes Version |   Compatibility    | Notes                                               |
|--------------------|:------------------:|-----------------------------------------------------|
| `1.21.x`           | :white_check_mark: | No known issues                                     |
| `1.22.x`           | :white_check_mark: | No known issues                                     |
| `1.23.x`           | :white_check_mark: | No known issues                                     |
| `1.24.x`           |     :warning:      | Conformance tests passed. Not officially supported. |

Check the [compatibility matrix][compatibility-matrix] for additional informations about previous releases of the modules.

## Usage

### Prerequisites

| Tool                        | Version   | Description                                                                                                                                                    |
|-----------------------------|-----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [furyctl][furyctl-repo]     | `>=0.6.0` | The recommended tool to download and manage KFD modules and their packages. To learn more about `furyctl` read the [official documentation][furyctl-repo].     |
| [kustomize][kustomize-repo] | `>=3.5.0` | Packages are customized using `kustomize`. To learn how to create your customization layer with `kustomize`, please refer to the [repository][kustomize-repo]. |

### Deployment

1. List the packages you want to deploy and their version in a `Furyfile.yml`

```yaml
bases:
  - name: logging/cerebro
    version: "v3.0.0"
  - name: logging/opensearch-single
    version: "v3.0.0"
  - name: logging/opensearch-dashboards
    version: "v3.0.0"
  - name: logging/logging-operator
    version: "v3.0.0"
  - name: logging/logging-operated
    version: "v3.0.0"
  - name: logging/configs
    version: "v3.0.0"
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
- ./vendor/katalog/logging/configs
```

5. To deploy the packages to your cluster, execute:

```bash
kustomize build . | kubectl apply -f -
```

### Common Customisations

#### Setup a high-availability three-node opensearch

Logging module offers an out of the box, highly-available setup for `opensearch` instead of a single node version. To set this up, in the `Furyfile` and `kustomization`, you can replace `opensearch-single` with `opensearch-triple`.

<!-- Links -->

[opensearch-page]: https://opensearch.org
[opensearch-dashboards-page]: https://opensearch.org
[fluentbit-page]: https://fluentbit.io/
[fluentd-page]: https://www.fluentd.org/
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

In case you experience any problem with the module, please [open a new issue](https://github.com/sighupio/fury-kubernetes-logging/issues/new/choose).

## License

This module is open-source and it's released under the following [LICENSE](LICENSE)

<!-- </FOOTER> -->
