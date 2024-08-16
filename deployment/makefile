.PHONY: create-config-maps
create-config-maps:
	echo "If this fails you probably need to delete and remake your configmaps. Run 'make delete-config-maps' and then 'make create-config-maps'"
	kubectl create configmap consuldataplanedashboard --from-file=../dashboards/consuldataplanedashboard.json
	kubectl create configmap consulservicedashboard --from-file=../dashboards/consulservicedashboard.json
	kubectl create configmap consulservicetoservicedashboard --from-file=../dashboards/consulservicetoservicedashboard.json
	kubectl create configmap consulaccesslogsanderrors --from-file=../dashboards/consulaccesslogsanderrors.json
	kubectl create configmap consulk8smonitoring --from-file=../dashboards/consulk8smonitoring.json


.PHONY: delete-config-maps
delete-config-maps:
	kubectl delete configmap consuldataplanedashboard
	kubectl delete configmap consulservicedashboard
	kubectl delete configmap consulservicetoservicedashboard
	kubectl delete configmap consulaccesslogsanderrors 
	kubectl delete configmap consulk8smonitoring


.PHONY: install-observability
install-observability: install-prometheus install-loki install-grafana

.PHONY: install-prometheus
install-prometheus:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
	helm upgrade --install prometheus --values helm/prometheus.yaml prometheus-community/prometheus --version "15.5.3" && \
	kubectl rollout status deployment prometheus-server --namespace default --timeout=300s


.PHONY: install-loki
install-loki:
	# Loki comes from the Grafana Helm repo
	helm repo add grafana https://grafana.github.io/helm-charts
	helm upgrade --install loki --values helm/loki.yaml grafana/loki-stack --version "2.9.9" && \
    kubectl rollout status statefulset loki --namespace default --timeout=300s

.PHONY: install-grafana
install-grafana:
	helm repo add grafana https://grafana.github.io/helm-charts && \
    helm upgrade --install grafana --values helm/grafana.yaml grafana/grafana --version "6.23.1" && \
    kubectl rollout status deployment grafana --namespace default --timeout=300s