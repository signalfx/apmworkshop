Set up the SFX Environment variables in `~/apmworkshop/apm/k8s/signalfx-k8s.yaml`

| Value | Description |
|-------|-------------|
|`YOURREALMHERE`| your realm i.e. US1|
|`YOURTOKENHERE`| your token i.e. av9dd9ckdr9|

Create the OpenTelemetry Collector deployment:  
`kubectl create -f signalfx-k8s.yaml`  

Tell your SmartAgent pod to send the spans and metrics to the OpenTelemetry Collector deployment:  

```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=http://otel-collector:9943 \
--set traceEndpointUrl=http://otel-collector:7276/v2/trace
```

To delete the collector:  

Tell your SmartAgent pod to send the spans and metrics to the Splunk APM service.  

```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=https://ingest.YOURREALMERE.signalfx.com \
--set traceEndpointUrl=https://ingest.YOUREALMHERE.signalfx.com/v2/trace
```
i.e.
```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=https://ingest.US1.signalfx.com \
--set traceEndpointUrl=https://ingest.US1.signalfx.com/v2/trace
```

Delete collector k8s components:

```
kubectl delete deployment otel-collector && \
kubectl delete service otel-collector && \
kubectl delete configmap otel-collector-conf
```
