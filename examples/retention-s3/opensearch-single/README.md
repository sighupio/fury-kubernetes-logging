# Opensearch Snapshot and Restore Plugin

This plugin provides a way to take snapshots of an index and restore it later. It also provides APIs to manage the snapshots.
The constraints of the plugin are:

- The snapshot is taken from a running cluster and can only be restored to a cluster with the same set of plugins installed.
- AWS S3 is the only supported repository for now.

## Getting Started

In the [secret](./secrets/secret-snapshot-s3.env) file, you need to set the following environment variables:

* `AWS_ACCESS_KEY_ID`: AWS access key ID
* `AWS_SECRET_ACCESS_KEY`: AWS secret access key
* `AWS_REGION`: AWS region
* `S3_BUCKET`: S3 bucket name

While in the [configmap](./confs/configmap-snapshot-s3.env) file, you need to set the following environment variables:

* `OPENSEARCH_HOST`: OpenSearch host (service name in the same namespace)
* `SNAPSHOT_S3_TASK`: Snapshot task name
* `BACKUP_UNIT_COUNT`: Number of units to backup

