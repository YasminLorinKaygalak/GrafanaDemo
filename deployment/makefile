.PHONY: create-config-maps
create-config-maps:
	kubectl create configmap consuldataplanedashboard --from-file=../consuldataplanedashboard.json
	kubectl create configmap consulservicedashboard --from-file=../consulservicedashboard.json
	kubectl create configmap consulservicetoservicedashboard --from-file=../consulservicetoservicedashboard.json
	kubectl create configmap grafanafinalaccesslogsanderrors --from-file=../grafanafinalaccesslogsanderrors.json

.PHONY: delete-config-maps
delete-config-maps:
	kubectl delete configmap consuldataplanedashboard
	kubectl delete configmap consulservicedashboard
	kubectl delete configmap consulservicetoservicedashboard
	kubectl delete configmap grafanafinalaccesslogsanderrors