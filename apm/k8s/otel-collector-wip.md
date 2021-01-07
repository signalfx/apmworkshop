```
export SFX_REALM=YOURREALMHERE
export SFX_TOKEN=YOURTOKENHERE

curl https://raw.githubusercontent.com/open-telemetry/opentelemetry-collector-contrib/master/exporter/sapmexporter/examples/signalfx-k8s.yaml -o signalfx-k8s.yaml

kubectl create -f signalfx-k8s.yaml

helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=http://otel-collector:9943 \
--set traceEndpointUrl=http://otel-collector:7276/v2/trace

kubectl delete deployment otel-collector && \
kubectl delete service otel-collector && \
kubectl delete configmap otel-collector-conf
```
