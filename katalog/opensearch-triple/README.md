# OpenSearch Triple

<!-- <KFD-DOCS> -->

OpenSearch is an open-source distributed search and analytics engine used for
log analytics. This package deploys a three-node OpenSearch cluster on
Kubernetes.

`opensearch-triple` is a high availability setup of OpenSearch, that sets
up a 3-node cluster of `OpenSearch` for a robust and reliable setup.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `opensearch` on prometheus. Please refer,
> [`opensearch-single](../opensearch-single/README.md#alerts) to read
> about the available Prometheus rules.

## Image repository and tag

* OpenSearch image: `opensearchproject/opensearch:1.2.4`
* OpenSearch repo: [OpenSearch on Github][opensearch-gh]
* OpenSearch documentation: [OpenSearch Homepage][opensearch-doc]

## Configuration

OpenSearch Triple is deployed with the following configuration:

- OpenSearch cluster with `3` nodes
- Listens on port `9200` for client connections
- Listens on port `9300` for node-to-node connections
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

<!-- Links -->

[opensearch-rules]: https://awesome-prometheus-alerts.grep.to/rules.html#elasticsearch-1
[opensearch-gh]: https://github.com/opensearch-project/OpenSearch
[opensearch-doc]: https://opensearch.org/docs/latest
[prometheus-operator]: https://github.com/sighupio/fury-kubernetes-monitoring/tree/master/katalog/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
