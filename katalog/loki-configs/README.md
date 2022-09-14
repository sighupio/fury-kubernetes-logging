# Logging operator configs

This package is a collection of logging operator Flow/ClusterFlow and Output/ClusterOutput configs.

## Requirements

- Kustomize >= `3.5.3`
- [logging-operated](../logging-operated)
- [logging-operator](../logging-operator)

## Configuration

> ⚠️ This package cannot be used together with `configs` package, one excludes the other.

Configurations available (patched from the base [configs](../configs) ) :

- [configs](configs): all the configurations.
- [configs/kubernetes](configs/kubernetes): only the cluster wide pods logging configuration.
- [configs/ingress-nginx](configs/ingress-nginx): only the nginx-ingress-controller logging configuration.
- [configs/audit](configs/audit): all the Kubernetes audit logs related configurations (with master selector and tolerations).
- [configs/events](configs/events): all the Kubernetes events related configurations (with master selector and tolerations).
- [configs/systemd](configs/systemd): all the systemd related configurations.
- [configs/systemd/kubelet](configs/systemd/common): kubelet, docker, ssh systemd service logs configuration.
- [configs/systemd/etcd](configs/systemd/etcd): only the etcd service logs configuration (with master selector and tolerations).

## Deployment

You can deploy all the configurations by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

You can also deploy only a configuration subset by running some of the following commands (for example):

```shell
kustomize build kubernetes | kubectl apply -f -
kustomize build ingress-nginx | kubectl apply -f -
kustomize build audit | kubectl apply -f -
kustomize build events | kubectl apply -f -
kustomize build systemd | kubectl apply -f -
kustomize build systemd/common | kubectl apply -f -
kustomize build systemd/etcd | kubectl apply -f -
```

## License

For license details please see [LICENSE](../../LICENSE)
