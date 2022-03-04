# Logging Operated

<!-- <KFD-DOCS> -->

The Logging operated package deploys the fluentd and fluentbit stack via Logging operator CRDs.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`
- [logging-operator][logging-operator]
- [prometheus-operator][prometheus-operator]

## Image repository and tag

* Logging operator: `ghcr.io/banzaicloud/logging-operator:3.17.0`

## Configuration

See the file [fluentd-fluentbit.yaml](fluentd-fluentbit.yml) in the root of the project for the stack configuration.

## Deployment

You can deploy Logging operated by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

<!-- Links -->

[logging-operator]: https://github.com/sighup-io/fury-kubernetes-logging/blob/master/katalog/logging-operator
[prometheus-operator]: https://github.com/sighup-io/fury-kubernetes-monitoring/blob/master/katalog/prometheus-operator

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
