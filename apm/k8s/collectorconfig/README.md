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
helm upgrade --install \ 
YOURCOLLECTORHERE \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

i.e.

```
helm upgrade  --install \
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
`helm upgrade --resuse-values`

[Click here to return to k8s APM lab](../README.md)