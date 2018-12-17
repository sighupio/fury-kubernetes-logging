# Fury Kubernetes Logging

This repo contains logging components to deploy on top of Kubernetes. Fury's logging stack is based on Elasticsearch, a very popular open source search engine commonly used for log analytics. Other components are used in integration with Elasticsearch.


## Requirements

All packages in this repository have following dependencies, for package specific dependencies please visit the single package's documentation:

- [Kubernetes](https://kubernetes.io) >= `v1.10.0`
- [Furyctl](https://github.com/sighup-io/furyctl) package manager to install Fury packages
- [Kustomize](https://github.com/kubernetes-sigs/kustomize) >= `v1` 


## Examples

To see examples on how to customize Fury distribution packages with kustomize please go to [examples](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/examples)


## Logging Packages

Following packages are included in Fury Kubernetes Logging katalog. All resources in these packages are going to be deployed in `logging` namespace in your Kubernetes cluster.

- [cerebro](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/cerebro) : Cerebro instance to manage Elasticsearch cluster via a graphical user interface
- [curator](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/curator) : Curator instance to manage Elasticsearch indices
- [elasticsearch-single](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/elasticsearch-single) : Single node Elasticsearch deployment
- [elasticsearch-triple](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/elasticsearch-triple) : Three node Elasticsearch cluster deployment
- [fluentd](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/fluentd) : fluentd instance to collect logging data and store in Elasticsearch
- [kibana](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/kibana) : Kibana instance to visualize and analyse Elasticsearch data.

You can click on each package to see its documentation.


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
