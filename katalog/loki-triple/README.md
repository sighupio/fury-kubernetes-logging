# Loki Triple

<!-- <KFD-DOCS> -->

> 🚨 This package is in technical preview and is subject to change.

Loki is a horizontally scalable, highly available, multi-tenant log aggregation system inspired by Prometheus.
It is designed to be very cost effective and easy to operate.
It does not index the contents of the logs, but rather a set of labels for each log stream.

`loki-triple` is a high availability setup of Loki, that sets
up a 3-node cluster of `loki` for a robust and reliable setup.


## Requirements

- Kubernetes >= `1.21.0`
- Kustomize >= `v3.5.3`
- [prometheus-operator from KFD monitoring module][prometheus-operator]
- [grafana from KFD monitoring module][grafana]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `loki` on prometheus

## Image repository and tag

* Loki image: `grafana/loki`
* Loki repo: [Loki on Github][loki-gh]

## Configuration

Fury distribution Loki Stack Single is deployed with the following configuration:

- Single node
- Listens on port `3100` for client connections and metrics scraping
- Resource limits are `200m` for CPU and `512Mi` for memory
- Requires `10Gi` storage

## Deployment

You can deploy Loki Stack Single by running the following command in the root of
the project:

```shell
kustomize build | kubectl apply -f -
```


## Alerts

Since we are configuring a `ServiceMonitor` in this package, followings Prometheus alerts are provided:

| Alert                             | Description                                                             | Severity | Interval |
|-----------------------------------|-------------------------------------------------------------------------|----------|:--------:|
| TBD              | TBD       | critical | 30m      |

<!-- Links -->

[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator
[grafana]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/grafana
[loki-gh]: https://github.com/grafana/loki

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
