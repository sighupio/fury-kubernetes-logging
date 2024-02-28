# Logging Operator - maintenance

To maintain the Logging Operator package, you should follow these steps.

Download the latest compressed archive of the `logging-operator` chart.

```bash
helm pull oci://ghcr.io/kube-logging/helm-charts/logging-operator
```

Extract to a folder of your choice, for example: `/tmp/logging-operator`.

```bash
tar xfz logging-operator-*.tgz -C /tmp
```

Run the following command:

```bash
helm template logging-operator /tmp/logging-operator/ -n logging > logging-operator-built.yaml
```

With the `logging-operator-built.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

Notice that requests and limits have been added to the operator deployment.

Eventually update CRDs in the `./crds` folder with the CRDs from the directory
`/tmp/logging-operator/crds`.
