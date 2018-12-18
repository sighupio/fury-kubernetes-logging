# Elasticsearch Single Katalog

Elasticsearch is an open source distributed search and analytics engine used for log analytics, full-text search, business-intelligence, etc. This package deploys a single node Elasticsearch cluster on Kubernetes.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`
- [prometheus-operator](https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/prometheus-operator)


## Image repository and tag

* Elasticsearch image: `docker.elastic.co/elasticsearch/elasticsearch:6.4.1`
* Elasticsearch repo: https://github.com/elastic/elasticsearch 
* Elasticsearch documentation:  https://www.elastic.co/guide/en/elasticsearch/reference/6.4/index.html


## Configuration

Fury distribution Elasticsearch Single is deployed with following configuration:

- Elasticsearch cluster with `1` node
- Listens on port `9200` for client connections
- Listens on port `9300` for node-to-node connections
- Uses default unicast Zen Discovery module to discover Elasticsearch nodes 
- Resource limits are `2000m` for CPU and `3G` for memory
- Requires `30Gi` storage (with default storage type of Provider)
- Prometheus exporter integrated to expose Elasticsearch metrics
- Metrics are scraped by Prometheus every `30s`


## Deployment

You can deploy Elasticsearch Triple by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`



## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
