## Istio Setup

This exercise will install an Istio service mesh on a kubernetes cluster that directs external requests to a Python Slask server.

Both the service mesh and the Flask server will emit spans.

The result will show tracing of the request through the mesh to the Flask server.

### Step 1: Install OpenTelemetry Collector  

Install Splunk Otel Collector in its own namespace:  
`kubectl create namespace splunk-otel-collector`

Follow Data Setup but add:  
`--namespace splunk-otel-collector`   
`--set autodetect.istio=true`

i.e.

helm install \
--set splunkAccessToken='YOURTOKENHERE' \
--set clusterName='YOURCLUSTERNAMEHERE' \
--set provider=' ' \
--set distro=' ' \
--set splunkRealm='YOURREALMHERE' \
--set otelCollector.enabled='true' \
--namespace splunk-otel-collector \
--set autodetect.istio=true \
--generate-name \
splunk-otel-collector-chart/splunk-otel-collector

### Step 2: Set Up Istio 

Set up Istio:
https://istio.io/latest/docs/setup/getting-started/#install  

`curl -L https://istio.io/downloadIstio | sh -`  

The default Istio Operator configuration needs to be updated to ensure the best observability with Splunk.

- The sampling rate needs to be set to 100%
- Tag lenght restrictions need to be increased
- The collector needs to be set as the destination for spans

To install the Splunk tracing profile for Istio:  

Change to the Istio install directory:  
`./bin/istioctl install -f ~/apmworkshop/apm/k8s/istio/tracing.yaml`

### Step 3: Deploy Istio configurations and example Flask microservice   

Set ingress ports for Nodeport example and configure ingress host for local k3s workshop example:  
`source setup-envs.sh`  

Validate config:   
`env | grep INGRESS`   

Deploy Flask service:  
`kubectl apply -f flask-deployment-istio.yaml`  

Single test Flask service:  
`source test-flask.sh`  

Results should show a direct request to the Flask server:  

```
You getted: b'' Request headers: Host: localhost:30001
User-Agent: curl/7.68.0
Accept: */*
Server: 1
```

Single test Istio:  
`source test-istio.sh`  

When hitting the service mesh from outside the cluster, you'll receive the mesh diagnostic data plus the B3 Trace/Span ID:

```
You getted: b'' Request headers: Host: 172.31.19.248:31177
User-Agent: curl/7.68.0
Accept: */*
Server: 1
X-Forwarded-For: 10.42.0.1
X-Forwarded-Proto: http
X-Envoy-Internal: true
X-Request-Id: 447af547-7b8f-96db-a0b5-08efce526a8d
X-Envoy-Decorator-Operation: server-flask-otel-k8s.default.svc.cluster.local:5000/echo
X-Envoy-Peer-Metadata: ChQKDkFQUF9DT05UQUlORVJTEgIaAAoaCgpDTFVTVEVSX0lEEgwaCkt1YmVybmV0ZXMKGQoNSVNUSU9fVkVSU0lPThIIGgYxLjEwLjIKvgMKBkxBQkVMUxKzAyqwAwodCgNhcHASFhoUaXN0aW8taW5ncmVzc2dhdGV3YXkKEwoFY2hhcnQSChoIZ2F0ZXdheXMKFAoIaGVyaXRhZ2USCBoGVGlsbGVyCjYKKWluc3RhbGwub3BlcmF0b3IuaXN0aW8uaW8vb3duaW5nLXJlc291cmNlEgkaB3Vua25vd24KGQoFaXN0aW8SEBoOaW5ncmVzc2dhdGV3YXkKGQoMaXN0aW8uaW8vcmV2EgkaB2RlZmF1bHQKMAobb3BlcmF0b3IuaXN0aW8uaW8vY29tcG9uZW50EhEaD0luZ3Jlc3NHYXRld2F5cwogChFwb2QtdGVtcGxhdGUtaGFzaBILGgk3ZDk3Zjc4ZjUKEgoHcmVsZWFzZRIHGgVpc3Rpbwo5Ch9zZXJ2aWNlLmlzdGlvLmlvL2Nhbm9uaWNhbC1uYW1lEhYaFGlzdGlvLWluZ3Jlc3NnYXRld2F5Ci8KI3NlcnZpY2UuaXN0aW8uaW8vY2Fub25pY2FsLXJldmlzaW9uEggaBmxhdGVzdAoiChdzaWRlY2FyLmlzdGlvLmlvL2luamVjdBIHGgVmYWxzZQoaCgdNRVNIX0lEEg8aDWNsdXN0ZXIubG9jYWwKLgoETkFNRRImGiRpc3Rpby1pbmdyZXNzZ2F0ZXdheS03ZDk3Zjc4ZjUtZGc1emMKGwoJTkFNRVNQQUNFEg4aDGlzdGlvLXN5c3RlbQpdCgVPV05FUhJUGlJrdWJlcm5ldGVzOi8vYXBpcy9hcHBzL3YxL25hbWVzcGFjZXMvaXN0aW8tc3lzdGVtL2RlcGxveW1lbnRzL2lzdGlvLWluZ3Jlc3NnYXRld2F5ChcKEVBMQVRGT1JNX01FVEFEQVRBEgIqAAonCg1XT1JLTE9BRF9OQU1FEhYaFGlzdGlvLWluZ3Jlc3NnYXRld2F5
X-Envoy-Peer-Metadata-Id: router~10.42.0.11~istio-ingressgateway-7d97f78f5-dg5zc.istio-system~istio-system.svc.cluster.local
X-Envoy-Attempt-Count: 1
X-B3-Traceid: 5035304e854aa834e990df295b1d98e9
X-B3-Spanid: e990df295b1d98e9
X-B3-Sampled: 1
```

To generate many requests so that the example appears in the APM service map, use the load generator:  

Load gen Istio:  
`source loadgen.sh`  

Stop loadgen:  
`ctrl-c`  

Cleanup:  
remove k8s examples:  
`source delete-all.sh`

Remove Istio:  
`istioctl x uninstall --purge`