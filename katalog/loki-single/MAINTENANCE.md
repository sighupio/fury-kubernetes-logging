# Loki Stack - maintenance

To maintain the Loki Stack package, you should follow this steps.

Download the latest tgz from [Grafana Helm Charts Loki Stack releseas][github-releases].

Extract to a folder of your choice, for example: `/tmp/loki-stack`.

Run the following command:

```bash
helm template loki-stack /tmp/loki-stack --set grafana.enabled=false --set loki.serviceMonitor.enabled=true -n logging > loki-stack-built.yaml
```

With the `oki-stack-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

[github-releases]: https://github.com/grafana/helm-charts/releases?q=loki-stack&expanded=true