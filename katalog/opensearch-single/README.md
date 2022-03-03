# OpenSearch Single

<!-- <KFD-DOCS> -->

OpenSearch is an open-source distributed search and analytics engine used for
log analytics. This package deploys a single node OpenSearch cluster on
Kubernetes.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `elasticsearch` on prometheus

## Image repository and tag

* OpenSearch image: `opensearchproject/opensearch:1.2.4`
* OpenSearch repo: [OpenSearch on Github][opensearch-gh]
* OpenSearch documentation: [OpenSearch Homepage][opensearch-doc]

## Configuration

Fury distribution OpenSearch Single is deployed with the following configuration:

- Single node
- Listens on port `9200` for client connections
- Listens on port `9300` for node-to-node connections
- Uses default unicast Zen Discovery module to discover Elasticsearch nodes
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

To learn how to customize compute resources for OpenSearch please follow the
[example](../../examples/opensearch-resources).

## Alerts

Since we are configuring a `ServiceMonitor` in this package, followings Prometheus [alerts][es-rules] are already defined:

| Alert                             | Description                                                             | Severity | Interval |
|-----------------------------------|-------------------------------------------------------------------------|----------|:--------:|
| OpenSearchClusterRed              | This alert fires when the health of the opensearch cluster is RED       | critical | 30m      |
| OpenSearchYellow                  | This alert fires when the health of the opensearch cluster is YELLOW    | warning  | 30m      |
| OpenSearchOfRelocationShards      | This alert fires when there are relocating shards for 30 minutes        | warning  | 30m      |
| OpenSearchOfInitializingShards    | This alert fires when there are initializing shards for 30 minutes      | warning  | 30m      |
| OpenSearchOfUnassignedShards      | This alert fires when there are unassigned shards for 30 minutes        | warning  | 30m      |
| OpenSearchOfPendingTasks          | This alert fires when there pending task for 30 minutes                 | warning  | 30m      |

<!-- Links -->

[opensearch-rules]: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/
[opensearch-gh]: https://github.com/opensearch-project/OpenSearch
[opensearch-doc]: https://opensearch.org/docs/latest
[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)