# Cerebro Deployment

This example shows how to customize Cerebro configuration to add basic
authentication to the web interface.

0. Run furyctl to get packages: `furyctl install --dev`

1. You can modify Cerebro configuration by editing the `application.conf` file.

2. Run `make build` to see output of kustomize with your modifications.

3. Once you're satisfied with generated output run `make deploy` to deploy it on cluster.
