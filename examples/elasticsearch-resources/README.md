# Elasticsearch Deployment

This example shows how to customize resources limits and requests for
Elasticsearch. It sets less CPU and memory resources respect to Fury
distribution package. A Container is guaranteed to have as much CPU/memory as it
requests, but is not allowed to use more than its limits. To learn more about
assigning compute resources to pods and containers please follow the Kubernetes
[documentation](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/).

0. Run furyctl to get packages: `$ furyctl install --dev`

1. You can modify `limit` and `request` values for CPU and memory resources in `set-resources.yml` based on your needs.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
