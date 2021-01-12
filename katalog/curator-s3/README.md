# Curator S3

Curator helps you manage your Elasticsearch indices and snapshots via various
operations like delete, snapshot, and shard allocation routing. It's mainly used
to managed retention of your infrastructure logs to a given value.

## Requirements

-   It requires elasticsearch with installed the plugin `repository-s3`
-   Kubernetes >= `1.17.0`
-   Kustomize >= `v3`

## Image repository and tag

-   The Dockerfile of elasticsearch should be like [this](elasticsearch/Dockerfile)
-   Curator image: `quay.io/sighup/curator:5.8.3_3.8-alpine_3.13`
-   Curator repo: [https://github.com/elastic/curator](https://github.com/elastic/curator)
-   Curator documentation:
    [https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html](https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html)

## Configuration

-   Replica number: `1`
-   Unit set as `30 days`
-   Curator will run every night at 00:15 to check if some indexes need deleting
-   Resource limits are `300m` for CPU and `800Mi` for memory
-   AWS bucket configuration secret file [curator-aws](../../examples/curator-s3-deployment/secret/curator-aws.env)

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

## License

For license details please see [LICENSE](../../LICENSE)
