# Logging Core Module Release 3.0.0

Welcome to the latest release of `logging` module of [`Kubernetes Fury
Distribution`](https://github.com/sighupio/fury-distribution) maintained by team
SIGHUP.

⚠️ This is a major release including a **breaking change** that replaces Elasticsearch and Kibana stack with the OpenSearch alternative.
Curator and its variants are also removed.

## Component Images 🚢

| Component                | Supported Version                                                                                      | Previous Version |
|--------------------------|--------------------------------------------------------------------------------------------------------|------------------|
| `opensearch`             | [`v2.0.0`](https://github.com/opensearch-project/OpenSearch/releases/tag/2.0.0)                        | `New component`  |
| `opensearch-dashboards`  | [`v2.0.0`](https://github.com/opensearch-project/OpenSearch-Dashboards/releases/tag/2.0.0)             | `New component`  |
| `cerebro`                | [`v0.9.4`](https://github.com/lmenezes/cerebro/releases/tag/v0.9.4)                                    | `No update`      |
| `logging-operator`       | [`v3.17.6`](https://github.com/banzaicloud/logging-operator/releases/tag/3.17.6)                       | `v3.17.2`        |
| `loki-stack`             | [`v2.4.2`](https://github.com/grafana/loki/releases/tag/v2.4.2)                                        | `New component`  |

> Please refer the individual release notes to get a detailed info on the
> releases.

## New package: Welcome OpenSearch! 📕

This release completely removes the Elasticsearch and Kibana stack in favor of the OpenSearch cluster and OpenSearch Dashboards UI.

## Removals: Curator and its variants 🚮

This release completely removes Curator package and its variants. The index expiration is now managed via ISM policies on the OpenSearch cluster.

## Technical preview: Loki 🔬

We are also adding Loki storage as an alternative to OpenSearch. This is a preview release and is not considered production ready.

## Update Guide 🦮

The update procedure is pretty straightforward, you just need to install the new stack.
The suggested approach is to maintain the old Elasticsearch and Kibana stack up&running while the new OpenSearch stack
starts to receive logs.

Also, all the configurations for the logging operator are updated to send logs to the new OpenSearch cluster.

Apply the new stack:

```bash
kustomize build vendor/katalog/logging-operator | kubectl apply -f -
kustomize build vendor/katalog/logging-operated | kubectl apply -f -
kustomize build vendor/katalog/configs | kubectl apply -f -
# You can choose the single or triple opensearch deployment
kustomize build vendor/katalog/opensearch-single | kubectl apply -f -
kustomize build vendor/katalog/opensearch-dashboards | kubectl apply -f -
```

> **NOTE**: *Run `kubectl apply` multiple times until you see no errors in the console*

When everything is ok on the OpenSearch side, you can proceed with the removal of the old stack:

```bash
kubectl delete statefulset elasticsearch -n logging
kubectl delete service elasticsearch -n logging
kubectl delete prometheusrule es-rules -n logging
kubectl delete servicemonitor elasticsearch -n logging
kubectl delete deployment kibana -n logging
kubectl delete service kibana -n logging
kubectl delete cronjob curator -n logging
```

<!-- Links -->







