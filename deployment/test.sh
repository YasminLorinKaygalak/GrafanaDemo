#!/usr/bin/env bash

# This script is to setup and verify consul-k8s is deployed properly in a K8s cluster
# with the following features enabled:
#   - ACL is enabled
#   - TLS is enabled
#   - Leader is elected
#   - Metrics are ingested by prometheus
#
# This script is idempotent.

# Obtain the self-signed certificate
kubectl get secret -- consul-ca-cert \
      -o jsonpath="{.data['tls\.crt']}" | base64 \
      --decode >ca.pem

# Assign anonymous token global-management policy
bootstrap_token=$(kubectl get secret consul-bootstrap-acl-token -o jsonpath='{.data.*}' | base64 -d)
if [ -z "$bootstrap_token" ]; then
      echo "\$bootstrap_token is not found"
else
      echo "Consul bootstrap token: ${bootstrap_token}"
      export CONSUL_HTTP_ADDR=http://127.0.0.1:8500
      consul acl token update -id anonymous \
            -policy-id 00000000-0000-0000-0000-000000000002 -ca-file ca.pem --token ${bootstrap_token}
fi

# Verify leader is elected
consul kv put --token ${bootstrap_token} -ca-file ca.pem foo bar

# Verify metrics from prometheus
value=$(curl -s http://localhost:9080/api/v1/query\?query\=consul_raft_apply | jq '.data.result[0].value[1]')

if [ -z "$value" ]; then
      echo "Fail to get metrics"
      exit 1
else
      echo "Success! Consul metrics are found in prometheus."
fi