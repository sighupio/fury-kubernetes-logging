# Logging Core Module Release v5.5.0

Welcome to the latest release of the `logging` module of [`SIGHUP Distribution`](https://github.com/sighupio/distribution) maintained by team SIGHUP by ReeVo.

This release adds support for Kubernetes 1.36 and updates all core components to their latest versions.

## Component Images 🚢

| Component               | Supported Version                                                                                             | Previous Version               |
|-------------------------|---------------------------------------------------------------------------------------------------------------|--------------------------------|
| `opensearch`            | [`v3.8.0`](https://github.com/opensearch-project/OpenSearch/releases/tag/3.8.0)                               | `v3.7.0`                       |
| `opensearch-dashboards` | [`v3.8.0`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/3.8.0)                    | `v3.7.0`                       |
| `logging-operator`      | [`v6.5.1`](https://github.com/kube-logging/logging-operator/releases/tag/6.5.1)                               | `6.0.3`                        |
| `loki-distributed`      | [`v3.7.2`](https://github.com/grafana/loki/releases/tag/v3.7.2)                                               | `v3.5.3`                       |
| `minio-ha`              | [`RELEASE.2026-07-17T12-07-51Z`](https://github.com/chainguard-forks/minio/tree/RELEASE.2026-07-17T12-07-51Z) | `RELEASE.2026-05-20T23-44-52Z` |

## Features ✨

### MinIO
Added two new Prometheus alerts: 
- `MinioClusterErasureSetQuorumLost`, fired when an erasure set loses quorum and MinIO can no longer guarantee reads/writes for that pool.
- `MinioKmsUnavailable`, fired when the KMS backend is offline and SSE-KMS operations fail.

## Breaking Changes 💔

No breaking changes detected.

## Update Guide 🦮

### Upgrade using the distribution

To upgrade the module using the distribution please refer to the [`official documentation`](https://docs.sighup.io/docs/upgrades/upgrades)

### Manual Upgrade

ℹ️ **Note:** Manually upgrading the module is deprecated. It is recommended to use it with the [`SIGHUP Distribution`](https://github.com/sighupio/distribution).

To upgrade the module run:

```bash
kustomize build | kubectl apply -f - --server-side
```