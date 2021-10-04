## OpenTelemetry Collector Configuration Exercise: Span Redaction

The Otel Collector has many powerful configuration options ranging from splitting telemetry to multiple destinations to sampling to span processing.  

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

***

## Span Processing Example: Redacting Data from a Span Attribute

**Step 1: Prepare values.yaml file for updating the Helm chart**  

Edit `spanprocessor.yaml` with thes values from Step 1.  

**Step 2: Update the Collector** 

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

**Step 3: Study the results**  

`Splunk Observability Portal -> APM -> Explore -> java-otel-manual-inst -> Traces`

Example `my.key` and you'll see that the value is `redacted` after applying the `spanprocessor.yaml` example

<img src="../../assets/25-span-redacted.png" width="360">  

**Conclusion**  

If you want to make changes and update the `spanprocessor.yaml` or add more configurations, use:  
`helm upgrade --resuse-values`

To see the structure of the inital Collector config: see the **Examine Otel Collector Config** section of the [k8s labs](../README.md)

[Click here to return to k8s APM labs](../README.md)