# Loki Distributed - maintenance

> [!NOTE]
> This package is named Loki Distributed because it was created using the upstream chart with the same name.
> From version 5.0.0 of the logging module the package has been migrated to use the `Loki` chart instead as
> upstream.

> [!WARNING]
> Ensure that changes made in this package are also aligned with the corresponding patches in the
> [distribution](https://github.com/sighupio/distribution/tree/main/templates/distribution/manifests/logging/patches) if needed.

The upgrade is handled automatically by the `upgrade` task. First, find the available chart versions:

```bash
mise run chart-versions
```

Then run:

```bash
mise run upgrade 18.12.1
```

The script performs the following operations on top of the chart output:

- Extracts the Loki config and gateway config from the chart-generated resources to `configs/`
- Removes the chart-generated Secret and ConfigMap from `deploy.yaml` (recreated by kustomize generators)
- Renames the gateway Service from `loki-distributed-gateway` to `loki-stack` for backward compatibility
- Downloads and customizes Loki mixins (dashboards and rules) matching the chart version

The following are handled by helm values in `MAINTENANCE.values.yaml` (no manual patching needed):

- `configStorageType: Secret` — Loki config is stored as a Secret instead of a ConfigMap
  - `configObjectName` overrides the Secret name
- `extraEnvFrom` — injects minio credentials Secret
- `memcached.enabled: false` — disables unused memcached ServiceAccount
- `monitoring.serviceMonitor.enabled: true` — chart generates the ServiceMonitor natively

All components follow the `loki-distributed` naming to maintain compatibility with existing resources.

## Loki mixins

The official [Loki mixins](https://github.com/grafana/loki/tree/main/production/loki-mixin-compiled) dashboard
and rules are downloaded and customized automatically by the `upgrade` task, matching the Loki version of the chart.
