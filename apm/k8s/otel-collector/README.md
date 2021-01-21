## OpenTelemetry Collector

"The OpenTelemetry Collector offers a vendor-agnostic implementation on how to receive, process and export telemetry data. In addition, it removes the need to run, operate and maintain multiple agents/collectors in order to support open-source telemetry data formats (e.g. Jaeger, Prometheus, etc.) sending to multiple open-source or commercial back-ends."

https://github.com/open-telemetry/opentelemetry-collector

For this workshop, we will install a minimal configuration, as a container, and steer the destination of metrics and spans emitted by the Splunk SmartAgent to the OpenTelemetry Collector deployment, which will then send them to the Splunk Observability Platform.

Once the Collector is receiving and re-transmitting telemetry, it can process, export, convert etc.

Official Splunk docs are [here](https://docs.signalfx.com/en/latest/apm/apm-getting-started/apm-opentelemetry-collector.html).  
Original k8s template on which this lab is based is [here](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/master/exporter/sapmexporter/examples/signalfx-k8s.yaml).

### Install OpenTelemetry Collector Deployment for Kubernetes

`cd ~/apmworkshop/apm/k8s/otel-collector/`

Set up the SFX Environment variables in `otel-collector-k8s.yaml`

| Value | Description |
|-------|-------------|
|`YOURREALMHERE`| your realm i.e. US1|
|`YOURTOKENHERE`| your token i.e. av9dd9ckdr9|

Create the OpenTelemetry Collector deployment:  
`kubectl create -f signalfx-k8s.yaml`  

Tell SmartAgent to send the spans and metrics to the OpenTelemetry Collector deployment:  

```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=http://otel-collector:9943 \
--set traceEndpointUrl=http://otel-collector:7276/v2/trace
```

To delete the collector:  

Tell SmartAgent to send the spans and metrics to the Splunk APM service:  

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
