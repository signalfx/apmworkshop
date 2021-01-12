Set up these env variables:  
```
export SFX_REALM=YOURREALMHERE
export SFX_TOKEN=YOURTOKENHERE
```

Get the example deplooyment yaml:  
`curl https://raw.githubusercontent.com/open-telemetry/opentelemetry-collector-contrib/master/exporter/sapmexporter/examples/signalfx-k8s.yaml -o signalfx-k8s.yaml`

Create the pod with the OpenTelemetry Collector:  
`kubectl create -f signalfx-k8s.yaml`  

Tell your SmartAgent pod to send the spans and metrics to the collector:  

```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=http://otel-collector:9943 \
--set traceEndpointUrl=http://otel-collector:7276/v2/trace
```

To delete the collector:  
```
kubectl delete deployment otel-collector && \
kubectl delete service otel-collector && \
kubectl delete configmap otel-collector-conf
```
