# Opensearch Dashboards - maintenance

The upgrade is handled automatically by the `upgrade` task. First, find the available chart versions:

```bash
mise run chart-versions
```

Then run:

```bash
mise run upgrade 3.8.0
```

**NOTE:** the chart version here MUST be kept in sync with [`opensearch-single`](../opensearch-single/MAINTENANCE.md).

What was customized:

- opensearch-dashboards created with secretGenerator
- security plugin is disabled with a custom command for the container, we expect security on the ingress level or configured manually (in consequence `OPENSEARCH_HOSTS` is switched to http)
- A CronJob (`index-patterns-cronjob`) is deployed to populate index pattern fields. Starting from OpenSearch Dashboards 3.6.0, index pattern fields are no longer automatically refreshed (see [opensearch-project/OpenSearch-Dashboards#11653](https://github.com/opensearch-project/OpenSearch-Dashboards/pull/11653)). The CronJob fetches fields via `_fields_for_wildcard` and updates each index pattern saved object with the resolved mappings.

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases
