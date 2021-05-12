### OpenTelemetry Collector Configuration

The OpenTelemetry Collector has many powerful configuration options ranging from splitting telemetry to multiple destinations to sampling to span processing.  

Processor documentation: https://github.com/open-telemetry/opentelemetry-collector/tree/main/processor  

Collector config examples: https://github.com/signalfx/splunk-otel-collector-chart/tree/main/examples  

Full documentation: https://github.com/signalfx/splunk-otel-collector  

**Prepare values for Collector update**  

`helm list`  

`helm get values NAME`  

i.e. `helm get values splunk-otel-collector-1620609739`

make note of:
`clusterNAME`
`splunkAccessToken`
`splunkRealm`

###

## Span Processing

**Step SP1: Prepare values.yaml file for updating the Helm chart**  

Edit `spanprocessor.yaml` with thes values from Step 1.  

**Step SP2: Update the Collector** 

Install the Collector configuration chart:  

```
helm upgrade \
YOURCOLLECTORHERE \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

i.e.

```
helm upgrade \
splunk-otel-collector-1620609739 \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

**Step SP3: Study the results**  

`Splunk Observability Portal -> APM -> Explore -> java-otel-manual-inst -> Traces`

:play_or_pause_button: [**VIDEO: finding a single trace**](../../assets/26-find-span.mp4)

Example `my.key` and you'll see that the value is `redacted` 

<img src="../../assets/25-span-redacted.png" width="360">  


If you want to make changes and update the `spanprocessor.yaml` or any values file, use:  
`helm upgrade --resuse-values` when re-applying i.e.  

```
helm upgrade \
--reuse-values splunk-otel-collector-1620655507 \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

###

## JVM Metrics

Note that for JVM Metrics to work, the deployment .yaml must have JVM metrics enabled as shown below. Our `java-deployment.yaml` example already has this and is publishing JVM metrics.  

```
    - name: SPLUNK_METRICS_ENDPOINT
      value: http://$(SPLUNK_OTEL_AGENT):9943
```

**Step JVM1: Prepare values.yaml file for updating the Helm chart**  


Edit `metricsreceiver.yaml` with thes values from Step 1.  

**Step JVM2: Update the Collector** 

Install the Collector configuration chart:  

```
helm upgrade \
YOURCOLLECTORHERE \
--values metricsreceiver.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

i.e.

```
helm upgrade \
splunk-otel-collector-1620609739 \
--values metricsreceiver.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

**Step JVM: Study the results**  

In `Dashboards->JVM Metrics`  

All JVM Metrics  

<img src="../../assets/27-jvm.png" width="360">    

Filter by Application by adding `service:SERVICENAMEHERE`  

<img src="../../assets/28-jvm-filter.png" width="360">    

[Click here to return to k8s APM lab](../README.md)