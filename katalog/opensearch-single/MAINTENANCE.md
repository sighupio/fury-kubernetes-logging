# Opensearch - maintenance

To maintain the Opensearch package, you should follow this steps.

Download the latest zip from [Opensearch Helm Charts][opensearch-helm-charts].

Extract to a folder of your choice, for example: `/tmp/opensearch`.

Run the following command:

```bash
helm template opensearch /tmp/opensearch -n logging > opensearch-built.yaml
```

What was customized:

- default storage from 8Gi to 30Gi
- removed helm release labels
- changed initContainer
- configured requests and limits + java opts for xms and xmx
- added prometheus exporter
- opensearch-cluster-master-config created with configMapGenerator instead of in-line as a configMap
- add opensearch-exporter-credentials secret for the exporter
- customized internal_users.yml config file with opensearch-internal-users secret

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases