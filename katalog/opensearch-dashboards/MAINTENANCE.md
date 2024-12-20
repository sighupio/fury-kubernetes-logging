# Opensearch Dashboards - maintenance

To maintain the Opensearch Dashboards package, you should follow these steps.

Download the latest zip from [Opensearch Helm Charts][opensearch-helm-charts].

Extract to a folder of your choice, for example: `/tmp/opensearch-dashboards`.

Alternatively you can download the chart with:

```bash
helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm pull opensearch/opensearch-dashboards --version 2.24.0 --untar --untardir /tmp # this command will download the chart in /tmp/opensearch-dashboards
```

> [!TIP]
> Chart v2.16.0 uses OpenSearch Dashboards v2.12.0

Run the following command:

```bash
helm template opensearch-dashboards /tmp/opensearch-dashboards -n logging > opensearch-dashboards-built.yaml
```

With the `opensearch-dashboards-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized:

- configured requests and limits
- added prometheus exporter
- opensearch-dashboards created with secretGenerator
- security plugin is disabled, we expect security on the ingress level or configured manually (in consequence `OPENSEARCH_HOSTS` is switched to http)

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases