# Elasticsearch Triple

<!-- <KFD-DOCS> -->

Elasticsearch is an open-source distributed search and analytics engine used for
log analytics. This package deploys a three-node Elasticsearch cluster on
Kubernetes.

`elasticsearch-triple` is a high availability setup of elasticsearch, that sets
up a 3-node cluster of `elasticsearch` for a robust and reliable setup.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `elasticsearch` on prometheus. Please refer,
> [`elasticsearch-single](../elasticsearch-single/README.md#alerts) to read
> about the available Prometheus rules.

## Image repository and tag

* Elasticsearch image: `elasticsearch/elasticsearch:7.16.2`
* Elasticsearch repo: [Elasticsearch on Github][es-gh]
* Elasticsearch documentation: [Elasticsearch Homepage][es-doc]

## Configuration

Fury distribution Elasticsearch Triple is deployed with the following configuration:

- Elasticsearch cluster with `3` nodes
- Listens on port `9200` for client connections
- Listens on port `9300` for node-to-node connections
- Uses default unicast Zen Discovery module to discover Elasticsearch nodes
- Resource limits are `2000m` for CPU and `4G` for memory
- Requires `30Gi` storage
- Only a single Elasticsearch node can be deployed on each node of the cluster
- Prometheus exporter to expose Elasticsearch metrics
- Metrics are scraped by Prometheus every `30s`

## Deployment

You can deploy Elasticsearch Triple by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

To learn how to customize compute resources for Elasticsearch please follow the
[example](../../examples/elasticsearch-resources).

<!-- Links -->

[es-rules]: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/
[es-gh]: https://github.com/elastic/elasticsearch
[es-doc]: https://www.elastic.co/guide/en/elasticsearch/reference/7.16/index.html
[prometheus-operator]: https://github.com/sighupio/fury-kubernetes-monitoring/tree/master/katalog/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
