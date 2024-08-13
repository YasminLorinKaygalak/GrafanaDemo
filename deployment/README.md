## Grafana example
This example demonstrates how to deploy a simple application with Consul Grafana dashboards.

This will deploy the following services:
- frontend
- backend
- ping
- pong

There is an api-gateway with a route to the frontend on port 80.
Ping and Pong talk to each other with `chaos-mode` enabled to simulate network failures.

It will also deploy Grafana, Loki, and Prometheus.

// TODO: Lorin talk about dashboards

### Install

```shell
helm upgrade --install consul hashicorp/consul --values helm/values.yaml
kubectl apply -f resources
make create-config-maps
make install-observability
```


### 

Port forward grafana to view the dashboards:

```shell
kubectl port-forward service/grafana 3000:3000
```

Visit localhost:3000