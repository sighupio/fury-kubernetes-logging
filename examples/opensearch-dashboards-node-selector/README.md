# Opensearch Dashboards Deployment

This example shows how to constrain assignment of Kibana pods to certain nodes.
Pods are going to be deployed only on nodes with the given label.

0. Run furyctl to get packages: `furyctl install --dev`

1. You can set another node label for `nodeSelector` field to constrain deployment on other nodes.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
