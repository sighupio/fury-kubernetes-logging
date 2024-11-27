# OpenSearch - maintenance

To maintain the OpenSearch package, you should follow these steps.

Download the latest zip from [OpenSearch Helm Charts][opensearch-helm-charts].

Extract to a folder of your choice, for example: `/tmp/opensearch`.

Alternatively you can download the chart with:

```bash
helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm pull opensearch/opensearch --version 2.26.0 --untar --untardir /tmp # this command will download the chart in /tmp/opensearch
```

> [!TIP]
> Chart v2.26.0 uses OpenSearch v2.17.1

Run the following command:

```bash
helm template opensearch /tmp/opensearch -n logging > opensearch-built.yaml
```

With the `opensearch-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized:

- default storage from 8Gi to 30Gi
- removed helm release labels
- replace initContainer definition
- configured requests and limits + java opts for xms and xmx
- added prometheus exporter
- added custom prometheus AlertRules
- changed metrics port to 9108
- opensearch-cluster-master-config created with configMapGenerator instead of in-line configMap
- security plugin is disabled, we expect security on the ingress level or configured manually

> [!WARNING]
> OpenSearch fails to start when running the AMD64 image on ARM64 machines (Apple Silicon like M1 and such). The kernel does not support
> `seccomp` and that makes some init checks fail.
> Workarounds:
>
> 1. Use temporarily the image from upstream instead of the one we sync that has compatibility with ARM64
> 2. Add the following snippet to the config or set the option via environment variables:

```yaml
bootstrap:
  system_call_filter: false
```

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases
