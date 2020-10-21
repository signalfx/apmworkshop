# signalfx-apm2-otel-setup
basic setup for apm2 and opentelemetry collector

```agent.yaml``` is configured for a host sending traces to an OpenTelemetry Collector - change values for your environment as indicated in the file. It should be copied to ```/etc/signalfx```

```collector.yaml``` is used for configuring the OpenTelemetry Collector - change values for your environment as indicated in the file. It should be in the directory where the OpenTelemetry Collector container will be instantiated as shown below.

Instantiate OpenTelemetry Collector in a docker container via the following:

```
sudo docker run --rm -p 13133:13133 -p 55679:55679 -p 7276:7276 -p 8888:8888 -p 9943:9943 \
-v ${PWD}/collector.yaml:/etc/collector.yaml:ro \
--name otelcol omnition/opentelemetry-collector-contrib:latest \
--config /etc/collector.yaml \
--new-metrics \
--legacy-metrics=false
```
