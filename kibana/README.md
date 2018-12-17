# Kibana Katalog

Kibana is an open source analytics and visualization platform for Elasticsearch. Kibana lets you perform advanced data analysis and visualize data in a variety of charts, tables, maps. You can use it to search, view, and interact with data stored in Elasticsearch indices. 

## Requirements

- Kubernetes >= `1.10.0`
- Kustomize >= `v1`
- [elasticsearch-single]() or [elasticsearch-triple]()


## Image repository and tag

* Kibana image: `docker.elastic.co/kibana/kibana:6.4.1`
* Kibana repo: https://github.com/elastic/kibana
* Kibana documentation: https://www.elastic.co/guide/en/kibana/6.4/index.html

## Configuration

- Replica number : `1`
- Listens on port `5601`
- Resource limits are `300m` for CPU and `800Mi` for memory


## Deployment

You can deploy Kibana by running following command in the root of the project:

`$ kustomize build | kubectl apply -f -`

### Accessing Kibana UI 

You can access Kibana web UI by port-forwarding on port `5601`:

`kubectl port-forward svc/kibana 5601:5601 --namespace logging`

Kibana will be available on `http://127.0.0.1:5601` from your browser.


## License

For license details please see [LICENSE](https://sighup.io/fury/license) 
