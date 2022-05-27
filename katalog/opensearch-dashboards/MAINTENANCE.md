# Opensearch DAshboards - maintenance

To maintain the Opensearch Dashboards package, you should follow this steps.

Download the latest zip from [Opensearch Helm Charts][opensearch-helm-charts].

Extract to a folder of your choice, for example: `/tmp/opensearch-dashboards`.

Run the following command:

```bash
helm template opensearch-dashboards /tmp/opensearch-dashboards -n logging > opensearch-dashboards-built.yaml
```

What was customized:

- configured requests and limits
- added prometheus exporter
- opensearch-dashboards created with secretGenerator
- security plugin is disabled, we expect security on the ingress level or configured manually

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases