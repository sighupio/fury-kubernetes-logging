# OpenSearch Triple

<!-- <KFD-DOCS> -->

OpenSearch is an open-source distributed search and analytics engine used for
log analytics. This package deploys a single node OpenSearch cluster on
Kubernetes.

`opensearch-triple` is a high availability setup of OpenSearch, that sets
up a 3-node cluster of `elasticsearch` for a robust and reliable setup.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `opensearch` on prometheus. Please refer,
> [`opensearch-single](../opensearch-single/README.md#alerts) to read
> about the available Prometheus rules.

## Image repository and tag

* Elasticsearch image: `elasticsearch/elasticsearch:7.16.2`
* Elasticsearch repo: [Elasticsearch on Github][es-gh]
* Elasticsearch documentation: [Elasticsearch Homepage][es-doc]

## Configuration

Fury distribution OpenSearch Single is deployed with the following configuration:

- OpenSearch cluster with `3` nodes
- Listens on port `9200` for client connections
- Listens on port `9300` for node-to-node connections
- Uses default unicast Zen Discovery module to discover Elasticsearch nodes
- Resource limits are `2000m` for CPU and `4G` for memory
- Requires `30Gi` storage
- Only a single OpenSearch node can be deployed on each node of the cluster
- Prometheus exporter to expose Opensearch metrics
- Metrics are scraped by Prometheus every `30s`

## Deployment

You can deploy OpenSearch Triple by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

To learn how to customize compute resources for OpenSearch please follow the
[example](../../examples/OpenSearch-resources).

<!-- Links -->

[opensearch-rules]: https://awesome-prometheus-alerts.grep.to/rules.html#elasticsearch-1
[opensearch-gh]: https://github.com/opensearch-project/OpenSearch
[opensearch-doc]: https://opensearch.org/docs/latest
[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
