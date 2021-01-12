# Curator s3 Deployment

This example shows how to customize Curator configuration in order to use the s3 index backup function before deleting indexes

0. Run furyctl to get packages: `furyctl install --dev`

1. Run `make build` to see output of kustomize with your modifications.

2. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
