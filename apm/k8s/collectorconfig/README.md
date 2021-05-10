helm list
helm get values NAME
i.e. helm get values splunk-otel-collector-1620609739

make note of:
`clusterNAME`
`splunkAccessToken`
`splunkRealm`

Edit enclosed .yaml with these values

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