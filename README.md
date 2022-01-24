<h1>
    <img src="https://github.com/sighupio/fury-distribution/blob/master/docs/assets/fury-epta-white.png?raw=true" align="left" width="90" style="margin-right: 15px"/>
    Kubernetes Fury Logging
</h1>

![Release](https://img.shields.io/github/v/release/sighupio/fury-kubernetes-logging?label=Latest%20Release)
![License](https://img.shields.io/github/license/sighupio/fury-kubernetes-logging?label=License)
![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack&label=Slack)

<!-- <KFD-DOCS> -->

**Kubernetes Fury Logging** provides a logging stack for the [Kubernetes Fury Distribution (KFD)][kfd-repo].

If you are new to KFD please refer to the [official documentation][kfd-docs] on how to get started with KFD.

## Overview

**Kubernetes Fury Logging** uses a collection of open source tools to provide the most resilient and robust logging stack for the cluster. 

The central piece of the stack is the CNCF certified open source search engine [elasticsearch][elastic-search-page], combined with its the analytics and visualization platform [kibana][kibana-page]. The logs are collected using a node-level data collection and enrichment agent [fluentbit][fluentbit-page](deployed as `Daemonsets`), pushing it to the Elasticsearch via [fluentd][fluentd-page].

Following is a high level design diagram of the module:

![logging module](docs/images/logging-module.png "Kubernetes Fury Logging")

All the components are deployed in the `logging` namespace in the cluster.

## Packages

The following packages are included in the Fury Kubernetes Logging katalog:
| Package                                              | Version  | Description                                                                                            |
|------------------------------------------------------|----------|--------------------------------------------------------------------------------------------------------|
| [cerebro](katalog/cerebro)                           | `0.9.4`  | Web admin tool that helps you manage your Elasticsearch cluster via a graphical user interface         |
| [curator](katalog/curator)                           | `5.8.4`  | Manges elasticserach indices and snapshots, alongwith configurations to set the retention log policies |
| [curator-s3](katalog/curator-s3)                     | `5.8.4`  |                                                                                                        |
| [elasticsearch-single](katalog/elasticsearch-single) | `7.16.2` | Single node elasticsearch deployment                                                                   |
| [elasticsearch-triple](katalog/elasticsearch-triple) | `7.16.2` | Three node high-availability elasticsearch deployment                                                  |
| [fluentd](katalog/fluentd)                           | `1.14.2` | Data collector for unified logging that can store collected data in Elasticsearch                      |
| [kibana](katalog/kibana)                             | `7.16.2` | Analytics and visualization platform for Elasticsearch                                                 |

Click on each package to see its full documentation.

## Compatibility

| Kubernetes Version |   Compatibility    |                        Notes                        |
| ------------------ | :----------------: | --------------------------------------------------- |
| `1.20.x`           | :white_check_mark: | No known issues                                     |
| `1.21.x`           | :white_check_mark: | No known issues                                     |
| `1.22.x`           | :white_check_mark: | No known issues                                     |
| `1.23.x`           |     :warning:      | Conformance tests passed. Not officially supported. |

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
    version: "v1.10.0"
  - name: logging/curator
    version: "v1.10.0"
  - name: logging/elasticsearch-single
    version: "v1.10.0"
  - name: logging/fluentd
    version: "v1.10.0"
  - name: logging/kibana
    version: "v1.10.0"
```

> See `furyctl` [documentation][furyctl-repo] for additional details about `Furyfile.yml` format.

2. Execute `furyctl vendor -H` to download the packages

3. Inspect the download packages under `./vendor/katalog/logging`.

4. Define a `kustomization.yaml` that includes the `./vendor/katalog/logging` directory as resource.

```yaml
resources:
- ./vendor/katalog/logging/cerebro
- ./vendor/katalog/logging/curator
- ./vendor/katalog/logging/elasticsearch-single
- ./vendor/katalog/logging/fluentd
- ./vendor/katalog/logging/kibana
```

5. To deploy the packages to your cluster, execute:

```bash
kustomize build . | kubectl apply -f -
```

### Common Customisations

#### Setup a high-availability three-node elasticsearch

Logging module offers an out of the box, highly-available setup for `elasticsearch` instead of a single node version. To set this up, in the `Furyfile` and `kustomization`, you can replace `elasticsearch-single` with `elasticsearch-triple`.

#### Setup curator with datastore in an s3 compliant bucket

To setup `curator` with `s3` compliant bucket support, we provide [`curator-s3`](katalog/curator-s3). To set it up, instead of `curator`, use `curator-s3` in `Furyfile` and `kustomization` in the above defined deployment step.

To configure the `s3` bucket, you will have to edit the file [`secret-es-backup.env`](katalog/curator-s3/secret-es-backup.env) with the following content, with the right configuration secrets:

``` sh
AWS_ACCESS_KEY_ID=AAAA
AWS_REGION=eu-west-1
AWS_SECRET_ACCESS_KEY=myKey
S3_BUCKET_NAME=my-s3_bucket
```

<!-- Links -->

[elastic-search-page]: https://www.elastic.co/elasticsearch/
[kibana-page]: https://www.elastic.co/kibana/
[fluentbit-page]: https://fluentbit.io/
[fluentd-page]: https://www.fluentd.org/
[kfd-repo]: https://github.com/sighupio/fury-distribution
[furyctl-repo]: https://github.com/sighupio/furyctl
[kustomize-repo]: https://github.com/kubernetes-sigs/kustomize
[kfd-docs]: https://docs.kubernetesfury.com/docs/distribution/
[compatibility-matrix]: docs/COMPATIBILITY_MATRIX.md

<!-- </KFD-DOCS> -->

<!-- <FOOTER> -->

## Contributing

Before contributing, please read first the [Contributing Guidelines](docs/CONTRIBUTING.md).

### Reporting Issues

In case you experience any problem with the module, please [open a new issue](https://github.com/sighupio/fury-kubernetes-logging/issues/new/choose).

## License

This module is open-source and it's released under the following [LICENSE](LICENSE)

<!-- </FOOTER> -->
