# Fluentd and Fluent-bit

<!-- <KFD-DOCS> -->

Fluentd and Fluent-bit plays an integral role in the logging module, in
collection and processing of data from the cluster and its transfer to the
`elasticsearch`.

These tools can be described in short as follows:

- Fluentd is a data collector for unified logging that can store collected data
  in various destinations. In our module, we configure `fluentd` to write the
  data to `elasticsearch`
- Fluent Bit is a multi-platform Log Processor and Forwarder which allows you to
  collect data/logs from different sources, unify and send them to multiple
  destinations

![Diagram](../../docs/images/fluentd-fluentbit.png)

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [prometheus-operator][prometheus-operator]

> Prometheus Operator is necessary since we configure a `ServiceMonitor` to make
> some metrics available from `fluentd` on prometheus

## Image repository and tag

* Fluentd image: `registry.sighup.io/sighup/fluentd-elasticsearch:v1.14.2-debian-1.0`
* Fluentd repo: [Fluentd on Giithub][fluentd-repo]
* Fluentd documentation: [Fluentd Homepage][fluentd-doc]
* Fluent-bit image: `fluent/fluent-bit:1.8.10`
* Fluent-bit repo: [Fluent-bit on Github][fluentbit-repo]
* Fluent-bit documentation: [Fluent-bit Homepage][fluentbit-doc]

## Configuration

- Listens on port `24231`
- Resource limits are `1000m` for CPU and `400Mi` for memory
- Configured to send log data to Elasticsearch
- Metrics are scraped every `30s` by Prometheus
- Integrates with [elasticsearch-single](../elasticsearch-single) and
  [elasticsearch-triple](../elasticsearch-triple)

## Deployment

You can deploy fluentd by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator
[fluentd-repo]: https://github.com/fluent/fluentd
[fluentd-doc]: https://docs.fluentd.org/quickstart
[fluentbit-repo]: https://github.com/fluent/fluent-bit
[fluentbit-doc]: https://docs.fluentbit.io/manual/

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
