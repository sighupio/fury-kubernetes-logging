# Curator S3

<!-- <KFD-DOCS> -->

Curator helps you manage your Elasticsearch indices and snapshots via various
operations like delete, snapshot, and shard allocation routing. It's mainly used
to managed retention of your infrastructure logs to a given value.

For `Curator` to work with `S3`, we will require an `AWS S3` compatible object
storage bucket. Along with this, we will have to configure `elasticsearch` with
[snapshot repository][snapshot-config]. To do so, we have added an
`InitContainer` in the `curator` manifest that does it by making a `PUT` request
to `/_snapshot/repository_name` endpoint of `elasticsearch`

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- `elasticsearch` with [snapshot repository configured][snapshot-config]
- `AWS S3` compatible object store bucket

## Image repository and tag

* Curator image: `registry.sighup.io/fury/curator;5.8.4_3.8-alpine`
* Curator repo: [curator at elastic Github][curtor-github]
* Curator documentation: [curator doc][curator-doc]

## Configuration

- Replica number: `1`
- Unit set as `30 days`
- Curator will run every night at 00:15 to check if some indexes need deleting
- Resource limits are `300m` for CPU and `800Mi` for memory
- AWS bucket configuration secret file [curator-aws](secret-es-backup.env)

## Deployment

You can deploy Curator by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

## List index stored in bucket

```shell
curl -XGET 'localhost:9200/_snapshot/s3-backup/_all?pretty'
```

## Restore index from the bucket into the elasticsearch

```shell
curator_id='curator-20190514223003'  #  the curator job id related with the task of the backup (you easily obtain this information from the list command above)

curl -XPOST "http://localhost:9200/_snapshot/s3-backup/${curator_id}/_restore?pretty=true&wait_for_completion=true"
```

<!-- Links -->

[snapshot-config]: https://www.elastic.co/guide/en/cloud/current/ec-aws-custom-repository.html#ec-aws-custom-repository
[curator-github]: https://github.com/elastic/curator
[curator-doc]: https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
