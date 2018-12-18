# Fluent-bit Deployment

This example shows how to deploy fluent-bit in place of fluentd. This deployment
will plug into the existing logging stack.

1. Run `make build` to see the output of kustomize and the objects that will be
   created.

2. Run `make deploy` to deploy it on the cluster.
