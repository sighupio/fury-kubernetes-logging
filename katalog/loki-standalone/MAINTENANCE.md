# Loki Stack - maintenance

To maintain the Loki Stack package, you should follow this steps.

Download the latest tgz from [Grafana Helm Charts Loki Stack releseas][github-releases].

Extract to a folder of your choice, for example: `/tmp/loki-stack`.

Alternatively you can download the chart with:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm pull grafana/loki-stack --version 2.6.4 --untar --untardir /tmp # this command will download the chart in /tmp/loki-stack
```

Run the following command:

```bash
helm template loki-stack /tmp/loki-stack --set grafana.enabled=false --set loki.serviceMonitor.enabled=true -n logging > loki-stack-built.yaml
```

With the `loki-stack-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized (what differs from the helm template command):

- Loki version has been updated to 2.7.3 to use the same version as the `loki-distributed` package

[github-releases]: https://github.com/grafana/helm-charts/releases?q=loki-stack&expanded=true