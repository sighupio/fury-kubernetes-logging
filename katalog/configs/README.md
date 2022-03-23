# Logging operator configs

This package is a collection of logging operator Flow/ClusterFlow and Output/ClusterOutput configs.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `3.3.0`
- [logging-operated](../logging-operated)
- [logging-operator](../logging-operator)

## Configuration

Configurations available:

- [configs](configs): all the configurations.
- [configs/kubernetes](configs/kubernetes): only the cluster wide pods logging configuration.
- [configs/ingress-nginx](configs/ingress-nginx): only the nginx-ingress-controller logging configuration.
- [configs/systemd](configs/systemd): all the systemd related configurations.
- [configs/audit](configs/audit): all the Kubernetes audit logs related configurations (with master selector and tolerations).
- [configs/events](configs/events): all the Kubernetes events related configurations (with master selector and tolerations).
- [configs/systemd/kubelet](configs/systemd/common): kubelet, docker, ssh systemd service logs configuration.
- [configs/systemd/etcd](configs/systemd/etcd): only the etcd service logs configuration (with master selector and tolerations).

## Deployment

You can deploy all the configurations by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

You can also deploy only one configuration by running the following command (for example):

```shell
kustomize build configs/kubernetes | kubectl apply -f -
```

## License

For license details please see [LICENSE](../../LICENSE)
