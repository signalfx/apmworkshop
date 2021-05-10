### OpenTelemetry Collector Configuration

The OpenTelemetry Collector has many powerful configuration options ranging from splitting telemetry to multiple destinations to sampling to span processing.  

Full documentation is here: https://github.com/signalfx/splunk-otel-collector  

Examples are here: https://github.com/signalfx/splunk-otel-collector-chart/tree/main/examples  

This example will show how to process/update a span by replacing a custom value with "redacted".

**Step 1: Prepare values for Collector update**  

`helm list`  

`helm get values NAME`  
i.e. helm get values splunk-otel-collector-1620609739

make note of:
`clusterNAME`
`splunkAccessToken`
`splunkRealm`

**Step 2: Prepare values.yaml file for updating the Helm chart**  

Edit `spanprocessor.yaml` with thes values from Step 1.  

**Step 3: Update the Collector** 

Install the Collector configuration chart:  

```helm install \
YOURCOLLECTORHERE \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

i.e.

```helm install \
splunk-otel-collector-1620609739 \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```

**Step 4: Study the results**  

`Splunk Observability Portal -> APM -> Explore -> java-otel-manual-inst -> Traces`

Example `my.key` and you'll see that the value is `redacted` 

If you want to make changes and update the `spanprocessor.yaml` or any values file, use:  
`helm upgrade --resuse-values` when re-applying i.e.  

```
helm upgrade \
--reuse-values splunk-otel-collector-1620655507 \
--values spanprocessor.yaml \
splunk-otel-collector-chart/splunk-otel-collector
```