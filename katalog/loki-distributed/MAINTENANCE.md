# Loki Distributed - maintenance

To maintain the Loki Stack package, you should follow these steps.

Download the latest tgz from [Grafana Helm Charts Loki Stack releseas][github-releases].

Extract to a folder of your choice, for example: `/tmp/loki-distributed`.

Alternatively you can download the chart with:

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm pull grafana/loki-distributed --version 0.69.4 --untar --untardir /tmp # this command will download the chart in /tmp/loki-stack
```

Run the following command:

```bash
helm template loki-distributed /tmp/loki-distributed --values MAINTENANCE.values.yaml -n logging > loki-distributed-built.yaml
```

With the `loki-stack-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

What was customized (what differs from the helm template command):

- Loki configuration has been moved on it's own file `configs/loki.yaml`
- Gateway service has been renamed as loki-stack to maintain compatibility with existing loki-configs
- Configmap loki-distributed has been changed to a secret


[github-releases]: https://github.com/grafana/helm-charts/releases?q=loki-stack&expanded=true