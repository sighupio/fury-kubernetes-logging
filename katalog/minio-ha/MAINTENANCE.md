# MinIO HA - maintenance

To maintain the MinIO package, you should follow these steps.

Download the latest tgz from [Main Minio repository releases](https://github.com/minio/minio/releases).

Extract to a folder of your choice, for example: `/tmp/minio`.

Run the following command:

```bash
helm template minio-logging /tmp/minio/helm/minio --values MAINTENANCE.values.yaml -n logging > minio-built.yaml
```

Minio's helm comes packaged with a specific mc (its client) version, to find out
which version comes with it you can inspect `/tmp/minio/helm/minio/values.yaml`.

What was customized (what differs from the helm template command):

- Config has been moved from the template output and generated via kustomize
- Added a custom init job to create buckets and add 7 day retention
- Added `preferredDuringSchedulingIgnoredDuringExecution` on minio pods

