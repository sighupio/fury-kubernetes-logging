# Logging Operator - maintenance

To maintain the Logging Operator package, you should follow this steps.

Download the latest zip from [Logging Operator Releases][logging-operator-github-releases].

Extract to a folder of your choice, for example: `/tmp/logging-operator`.

Run the following command:

```bash
helm template logging-operator ./tmp/logging-operator/charts/logging-operator -n logging > logging-operator-built.yaml
```

With the `logging-operator-build.yaml` file, check differences with the current `deploy.yml` file and change accordingly.

Eventually update CRDs in the `./crds` folder with the CRDs from the directory
`./tmp/logging-operator/charts/logging-operator/crds`.

[logging-operator-github-releases]: https://github.com/banzaicloud/logging-operator/releases