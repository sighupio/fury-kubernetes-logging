# OpenSearch Dashboards

<!-- <KFD-DOCS> -->

OpenSearch Dashboards is an open-source analytics and visualization platform for OpenSearch.
OpenSearch Dashboards lets you perform advanced data analysis and visualize data in a variety
of charts, tables, and maps. You can use it to search, view, and interact with data
stored in OpenSearch indices.

## Requirements

- Kubernetes >= `1.20.0`
- Kustomize >= `v3.3.X`

## Image repository and tag

* OpenSearch Dashboards image: `opensearchproject/opensearch-dashboards:1.2.0`
* OpenSearch Dashboards repo: [OpenSearch Dashboards on Github][opensearch-dashboards-github]
* OpenSearch Dashboards documentation: [OpenSearch Dashboards at elastic.co][opensearch-dashboards-doc]

## Configuration

- Replica number: `1`
- Listens on port `5601`
- Resource limits are `100m` for CPU and `512Mi` for memory
- Secured by `securiyContext` *(running as non-root, removed all Linux capabilities)*

## Deployment

You can deploy OpenSearch Dashboard by running the following command in the root of the project:

```shell
kustomize build | kubectl apply -f -
```

To learn how to constrain OpenSearch Dashboard deployment please see the
[example](../../examples/opensearch-dashboard-node-selector).

### Accessing OpenSearch Dashboards UI

You can access OpenSearch Dashboards web UI by port-forwarding on port `5601`:

```shell
kubectl port-forward svc/opensearch-dashboards 5601:5601 --namespace logging
```

OpenSearch Dashboards will be available on `http://127.0.0.1:5601` from your browser.

Links

[opensearch-dashboards-doc]: https://opensearch.org/docs/latest/dashboards/index/
[opensearch-dashboards-github]: https://github.com/opensearch-project/OpenSearch-Dashboards

<!-- </KFD-DOCS> -->

## License

For license details please see [LICENSE](../../LICENSE)
