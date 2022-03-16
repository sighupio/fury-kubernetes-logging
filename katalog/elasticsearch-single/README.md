# Elasticsearch Single

<!-- <KFD-DOCS> -->

Elasticsearch is an open-source distributed search and analytics engine used for
log analytics. This package deploys a single node Elasticsearch cluster on
Kubernetes.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `elasticsearch` on prometheus

## Image repository and tag

* Elasticsearch image: `elasticsearch/elasticsearch:7.16.2`
* Elasticsearch repo: [Elasticsearch on Github][es-gh]
* Elasticsearch documentation: [Elasticsearch Homepage][es-doc]

## Configuration

Fury distribution Elasticsearch Single is deployed with the following configuration:

- Single node
- Listens on port `9200` for client connections
- Listens on port `9300` for node-to-node connections
- Uses default unicast Zen Discovery module to discover Elasticsearch nodes
- Resource limits are `2000m` for CPU and `4G` for memory
- Requires `30Gi` storage
- Prometheus exporter to expose Elasticsearch metrics
- Metrics are scraped by Prometheus every `30s`

## Deployment

You can deploy Elasticsearch Single by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```

To learn how to customize compute resources for Elasticsearch please follow the
[example](../../examples/elasticsearch-resources).

## Alerts

Since we are configuring a `ServiceMonitor` in this package, followings Prometheus [alerts][es-rules] are already defined:

| Alert                             | Description                                                             | Severity | Interval |
|-----------------------------------|-------------------------------------------------------------------------|----------|:--------:|
| ElasticClusterRed                 | This alert fires when the health of the elasticsearch cluster is RED    | critical | 30m      |
| ElasticClusterYellow              | This alert fires when the health of the elasticsearch cluster is YELLOW | warning  | 30m      |
| ElasticNumberOfRelocationShards   | This alert fires when there are relocating shards for 30 minutes        | warning  | 30m      |
| ElasticNumberOfInitializingShards | This alert fires when there are initializing shards for 30 minutes      | warning  | 30m      |
| ElasticNumberOfUnassignedShards   | This alert fires when there are unassigned shards for 30 minutes        | warning  | 30m      |
| ElasticNumberOfPendingTasks       | This alert fires when there pending task for 30 minutes                 | warning  | 30m      |

<!-- Links -->

[es-rules]: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/
[es-gh]: https://github.com/elastic/elasticsearch
[es-doc]: https://www.elastic.co/guide/en/elasticsearch/reference/7.16/index.html
[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
