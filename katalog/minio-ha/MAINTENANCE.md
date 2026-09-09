# MinIO HA - maintenance

To maintain the MinIO package, you should follow these steps.

1. Find the latest versions:
   ```bash
   mise run minio-versions
   mise run mc-versions
   mise run prometheus-alerts-versions
   ```

2. Run the upgrade task with the desired versions:
   ```bash
   mise run upgrade RELEASE.2026-07-17T12-07-51Z RELEASE.2025-08-13T08-35-41Z 2026-04-10.1
   ```

What was customized:

- Secret `minio-logging` is generated from Kustomize, so it must be removed from `deploy.yaml`
- ConfigMap `minio-logging` is removed as it was not used
- Added a custom init job to create buckets and add 7-day retention