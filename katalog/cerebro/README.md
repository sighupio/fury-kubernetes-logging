# Cerebro Katalog

Cerebro is an open source web admin tool for Elasticsearch API, you can perform common tasks on Elasticsearch cluster via Cerebro's web interface.

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`


## Image repository and tag

* Cerebro image: : `lmenezes/cerebro:0.8.1`
* Cerebro repo: https://github.com/lmenezes/cerebro


## Configuration

Fury distribution Cerebro is deployed with following configuration:

- Replica number : `1`
- Requires no authentication
- Listens on port `9000`
- Resource limits are `600m` for CPU and `800Mi` for memory


## Deployment

You can deploy Cerebro by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`


### Accessing Cerebro UI

You can access Cerebro web UI by port-forwarding on port `9000`:

`kubectl port-forward svc/cerebro 9000:9000 --namespace logging`

Cerebro will be available on `http://127.0.0.1:9000` from your browser.

To learn how to add basic authentication for Cerebro please see the [example](https://github.com/sighup-io/fury-kubernetes-logging/tree/master/examples/cerebro-deployment)


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
