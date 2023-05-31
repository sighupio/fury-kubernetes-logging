# OpenSearch Single

<!-- <KFD-DOCS> -->

OpenSearch is an open-source distributed search and analytics engine used for
log analytics. This package deploys a single node OpenSearch cluster on
Kubernetes.

> ⚠️ Please note that the OpenSearch Single variant is not intended for production use. Please use [opensearch-triple](../opensearch-triple), the high-availability version, for production.

## Requirements

- Kubernetes >= `1.24.0`
- Kustomize = `v3.5.3`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `OpenSearch` on prometheus

## Image repository and tag

* OpenSearch image: `opensearchproject/opensearch:2.7.0`
* OpenSearch repo: [OpenSearch on Github][opensearch-gh]
* OpenSearch documentation: [OpenSearch Homepage][opensearch-doc]

## Configuration

Fury distribution OpenSearch Single is deployed with the following configuration:

- Single node
- Listens on port `9200` for client connections
- Resource limits are `2000m` for CPU and `4G` for memory
- Requires `30Gi` storage
- Prometheus exporter to expose OpenSearch metrics
- Metrics are scraped by Prometheus every `30s`

## Deployment

You can deploy OpenSearch Single by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```

## Alerts

Since we are configuring a `ServiceMonitor` in this package, the following Prometheus [alerts][opensearch-rules] are already defined:

| Alert                             | Description                                                             | Severity | Interval |
|-----------------------------------|-------------------------------------------------------------------------|----------|:--------:|
| OpenSearchClusterRed              | This alert fires when the health of the opensearch cluster is RED       | critical | 30m      |
| OpenSearchYellow                  | This alert fires when the health of the opensearch cluster is YELLOW    | warning  | 30m      |
| OpenSearchOfRelocationShards      | This alert fires when there are relocating shards for 30 minutes        | warning  | 30m      |
| OpenSearchOfInitializingShards    | This alert fires when there are initializing shards for 30 minutes      | warning  | 30m      |
| OpenSearchOfUnassignedShards      | This alert fires when there are unassigned shards for 30 minutes        | warning  | 30m      |
| OpenSearchOfPendingTasks          | This alert fires when there pending task for 30 minutes                 | warning  | 30m      |

> ℹ️ when using the OpenSearch single variant, the cluster will be in `YELLOW` state because of the single replica.

<!-- Links -->

[opensearch-rules]: https://awesome-prometheus-alerts.grep.to/rules.html#elasticsearch-1
[opensearch-gh]: https://github.com/opensearch-project/OpenSearch
[opensearch-doc]: https://opensearch.org/docs/latest
[prometheus-operator]: https://github.com/sighupio/fury-kubernetes-monitoring/tree/master/katalog/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
