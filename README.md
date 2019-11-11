# Fury Kubernetes Logging

This repo contains logging components to deploy on top of Kubernetes. Fury's
logging stack is based on Elasticsearch, a very popular open source search
engine commonly used for log analytics. Other components are used in integration
with Elasticsearch.

## Requirements

All packages in this repository have following dependencies, for package
specific dependencies please visit the single package's documentation:

- [Kubernetes](https://kubernetes.io) >= `v1.10.0`
- [Furyctl](https://github.com/sighup-io/furyctl) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= `v1`


## Examples

To see examples on how to customize Fury distribution packages with kustomize
please go to [examples](examples).


## Logging Packages

Following packages are included in Fury Kubernetes Logging katalog. All
resources in these packages are going to be deployed in `logging` namespace in
your Kubernetes cluster.

- [cerebro](katalog/cerebro): Cerebro instance to manage Elasticsearch cluster via a
  graphical user interface. Version: **0.8.1**
- [curator](katalog/curator): Curator instance to manage Elasticsearch indices. Version: **5.6.0**
- [elasticsearch-single](katalog/elasticsearch-single): Single node Elasticsearch
  deployment. Version: **6.4.1**
- [elasticsearch-triple](katalog/elasticsearch-triple): Three node Elasticsearch cluster
  deployment. Version: **6.4.1**
- [fluentd](katalog/fluentd): fluentd instance to collect logging data and store in
  Elasticsearch. Version: **1.7.2**
- [kibana](katalog/kibana): Kibana instance to visualize and analyse Elasticsearch data. Version: **6.4.1**

You can click on each package to see its documentation.


## Compatibility

| Module Version / Kubernetes Version | 1.14.X             | 1.15.X             | 1.16.X             |
|-------------------------------------|:------------------:|:------------------:|:------------------:|
| v1.0.0                              |                    |                    |                    |
| v1.1.0                              |                    |                    |                    |

- :white_check_mark: Compatible
- :warning: Has issues
- :x: Incompatible


## License

For license details please see [LICENSE](https://sighup.io/fury/license)
