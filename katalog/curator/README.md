# Curator

<!-- <KFD-DOCS> -->

Curator helps you manage your Elasticsearch indices and snapshots via various
operations like delete, snapshot, and shard allocation routing. It's mainly used
to managed retention of your infrastructure logs to a given value.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`

## Image repository and tag

* Curator image: `registry.sighup.io/fury/curator;5.8.4_3.8-alpine`
* Curator repo: [curator at elastic Github][curtor-github]
* Curator documentation: [curator doc][curator-doc]

## Configuration

- Replica number: `1`
- Unit set as `30 days`
- Curator will run every night at 00:15 to check if some indexes need deleting
- Resource limits are `300m` for CPU and `800Mi` for memory

## Deployment

You can deploy Curator by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[curator-github]: https://github.com/elastic/curator
[curator-doc]: https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
