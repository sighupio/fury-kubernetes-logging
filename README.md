# Fury Kubernetes Logging

This repo contains logging components to deploy on top of Kubernetes. Fury's
logging stack is based on Elasticsearch, a very popular open-source search
engine commonly used for log analytics. Other components are used in integration
with Elasticsearch.

## Requirements

All packages in this repository have following dependencies, for package
specific dependencies please visit the single package's documentation:

- [Kubernetes](https://kubernetes.io) >= `v1.18.0`
- [Furyctl](https://github.com/sighup-io/furyctl) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= `v3`


## Examples

To see examples on how to customize Fury distribution packages with kustomize
please go to [examples](examples).


## Logging Packages

The following packages are included in the Fury Kubernetes Logging katalog. All
resources in these packages are going to be deployed in the `logging` namespace in
your Kubernetes cluster.

- [cerebro](katalog/cerebro): Cerebro instance to manage Elasticsearch cluster via a
  graphical user interface. Version: **0.9.4**
- [curator](katalog/curator): Curator instance to manage Elasticsearch indices. Version: **5.8.4**
- [elasticsearch-single](katalog/elasticsearch-single): Single node Elasticsearch
  deployment. Version: **7.13.0**
- [elasticsearch-triple](katalog/elasticsearch-triple): Three node Elasticsearch cluster
  deployment. Version: **7.13.0**
- [fluentd](katalog/fluentd): fluentd instance to collect logging data and store in
  Elasticsearch. Version: **1.12.3**
- [kibana](katalog/kibana): Kibana instance to visualize and analyze Elasticsearch data. Version: **7.13.0**

You can click on each package to see its documentation.


## Compatibility

| Module Version / Kubernetes Version | 1.14.X             | 1.15.X             | 1.16.X             | 1.17.X             | 1.18.X             | 1.19.X             | 1.20.X             | 1.21.X             |
|-------------------------------------|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|
| v1.0.0                              | :white_check_mark: |                    |                    |                    |                    |                    |                    |                    |
| v1.1.0                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v1.2.0                              |                    |                    |                    |                    |                    |                    |                    |                    |
| v1.2.1                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v1.3.0                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v1.4.0                              | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v1.5.0                              |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |                    |                    |
| v1.6.0                              |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :warning:      |                    |                    |
| v1.7.0                              |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :warning:      |     :warning:      |
| v1.8.0                              |                    |                    |                    |                    | :white_check_mark: | :white_check_mark: | :white_check_mark: |     :warning:      |

- :white_check_mark: Compatible
- :warning: Has issues
- :x: Incompatible


### Warning

- :warning: : module version: `v1.7.0` and Kubernetes Version: `1.20.x`. It works as expected. Marked as warning
because it is not officially supported by [SIGHUP](https://sighup.io).
- :warning: : module version: `v1.8.0` and Kubernetes Version: `1.21.x`. It works as expected. Marked as warning
because it is not officially supported by [SIGHUP](https://sighup.io).


## License

For license details please see [LICENSE](LICENSE)
