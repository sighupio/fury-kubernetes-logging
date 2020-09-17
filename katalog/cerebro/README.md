# Cerebro

Cerebro is an open-source web admin tool for Elasticsearch API, you can perform
common tasks on the ElasticSearch cluster via Cerebro's web interface.

## Requirements

- Kubernetes >= `1.16.0`
- Kustomize >= `v3`

## Image repository and tag

* Cerebro image: `lmenezes/cerebro:0.9.2`
* Cerebro repo: [https://github.com/lmenezes/cerebro](https://github.com/lmenezes/cerebro)

## Configuration

Fury distribution Cerebro is deployed with the following configuration:

- Replica number: `1`
- Requires no authentication
- Listens on port `9000`
- Resource limits are `600m` for CPU and `800Mi` for memory

## Deployment

You can deploy Cerebro by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

### Accessing Cerebro UI

You can access Cerebro web UI by port-forwarding on port `9000`:

```shell
kubectl port-forward svc/cerebro 9000:9000 --namespace logging
```

Cerebro will be available on `http://127.0.0.1:9000` from your browser.

To learn how to add basic authentication for Cerebro please see the
[example](../../examples/cerebro-deployment).

## License

For license details please see [LICENSE](../../LICENSE)
