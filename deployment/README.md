## Grafana example
This example demonstrates how to deploy a simple application with Consul Grafana dashboards.

This will deploy the following services:
- frontend
- backend
- ping
  - Ping and Pong talk to each other with `chaos-mode` enabled to simulate network failures. See [rboyer/pingpong](https://github.com/rboyer/pingpong/tree/main) for more information.
- pong

This will deploy an API Gateway with the following routes:
- frontend on port 80 
- grafana on port 3000 to make it easier to access the dashboards without needing kube configs.

It will also deploy Grafana, Loki, and Prometheus.

// TODO: Lorin talk about dashboards

### Install

```shell
helm upgrade --install consul hashicorp/consul --values helm/values.yaml
kubectl apply -f resources
make create-config-maps
make install-observability
```