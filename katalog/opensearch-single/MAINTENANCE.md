# Opensearch - maintenance

To maintain the Opensearch package, you should follow this steps.

Download the latest zip from [Opensearch Helm Charts][opensearch-helm-charts].

Extract to a folder of your choice, for example: `/tmp/opensearch`.

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
- opensearch-cluster-master-config created with configMapGenerator instead of in-line configMap
- customized internal_users.yml config file with opensearch-internal-users secret
- security plugin is disabled, we expect security on the ingress level or configured manually

[opensearch-helm-charts]: https://github.com/opensearch-project/helm-charts/releases