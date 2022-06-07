# Opensearch DAshboards - maintenance

To maintain the Opensearch Dashboards package, you should follow this steps.

Download the latest zip from [Opensearch Helm Charts][opensearch-helm-charts].

Extract to a folder of your choice, for example: `/tmp/opensearch-dashboards`.

Alternatively you can download the chart with:

```bash
helm repo add opensearch https://opensearch-project.github.io/helm-charts/
helm pull opensearch/opensearch-dashboards --version 2.0.1 --untar --untardir /tmp # this command will download the chart in /tmp/opensearch-dashboards
```

Run the following command:

```bash
helm template opensearch-dashboards /tmp/opensearch-dashboards -n logging > opensearch-dashboards-built.yaml
```

With the `opensearch-dashboards-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized:

- configured requests and limits
- added prometheus exporter
- opensearch-dashboards created with secretGenerator
- security plugin is disabled, we expect security on the ingress level or configured manually

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases