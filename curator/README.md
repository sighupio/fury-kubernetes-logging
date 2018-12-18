# Curator Katalog

Curator helps you manage your Elasticsearch indices and snapshots via various operations from delete to snapshot to shard allocation routing.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`


## Image repository and tag

* Curator image: `njia0532/docker-curator`
* Curator repo: https://github.com/elastic/curator
* Curator documentation: https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html


## Configuration

- Replica number : `1`
- Unit set as `30 days`
- Resource limits are `300m` for CPU and `800Mi` for memory


## Deployment

You can deploy Curator by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
