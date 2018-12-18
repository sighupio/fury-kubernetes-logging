# Fluentd Katalog

Fluentd is an open source data collector for unified logging. It can store collected data in various destinations. In Fury Kubernetes Logging katalog fluentd is deployed to write records into Elasticsearch.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`
- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator)


## Image repository and tag

* Fluentd image: `sighup/fluentd-elasticsearch:1.2.8`
* Fluentd repo: https://github.com/fluent/fluentd
* Fluentd documentation: https://docs.fluentd.org/v1.0/articles/quickstart


## Configuration

- Listens on port `24231`
- Resource limits are `1000m` for CPU and `400Mi` for memory
- Configured to send log data to Elasticsearch 
- Metrics are scraped every `30s` by Prometheus
- Integrates with [elasticsearch-single]() and [elasticsearch-triple]()


## Deployment

You can deploy fluentd by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`



## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
