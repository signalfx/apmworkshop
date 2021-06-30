Install Splunk Otel Collector in its own namespace:  
`kubectl create namespace splunk-otel-collector`

Follow Data Setup but add:  
`--namespace splunk-otel-collector` 

i.e.

helm install \
--set splunkAccessToken='YOURTOKENHERE' \
--set clusterName='YOURCLUSTERNAMEHERE' \
--set provider=' ' \
--set distro=' ' \
--set splunkRealm='YOURREALMHERE' \
--set otelCollector.enabled='true' \
--namespace splunk-otel-collector \
--generate-name \
splunk-otel-collector-chart/splunk-otel-collector

Set up Istio:
https://istio.io/latest/docs/setup/getting-started/#install  

`curl -L https://istio.io/downloadIstio | sh -`  

The default Istio Operator configuration needs to be updated to ensure the best observability with Splunk.

- The sampling rate needs to be set to 100%
- Tag lenght restrictions need to be increased
- The collector needs to be set as the destination for spans

The `splunk-demo-profile.yaml` profile has all of these settings, copy the `splunk-demo-profile.yaml` file to the Istio directory:

```sh
cp splunk-demo-profile.yaml istio-1.?.?/manifests/profiles/splunk-demo.yaml
```

cd to the istio directory created above  

`export PATH=$PWD/bin:$PATH`  

The default Istio Operator configuration needs to be updated to ensure the best observability with Splunk.  

The sampling rate needs to be set to 100%  
Tag lenght restrictions need to be increased 
The collector needs to be set as the destination for spans

Copy the Splunk demo Istio profile to the Istio manifests directory:  
`cp splunk-demo-profile.yaml ~/istio-1.10.2/manifests/profiles/splunk-demo.yaml`

Change to the Istio binary directory and then:  
`istioctl install --manifests=./manifests/ --set profile=splunk-demo -y`

Enable defailt Envoy injection:  
`kubectl label namespace default istio-injection=enabled`  
=======
Now apply the Splunk demo profile

```sh
istioctl install --manifests=./manifests/ --set profile=splunk-demo -y
```

Update the default namespace to auto-inject the Istio proxy

```sh
kubectl label namespace default istio-injection=enabled
```

Enable Prometheus Metrics:  
`kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.10/samples/addons/prometheus.yaml` 

Enable tracing on Istio:  
`istioctl install -f istio-tracing.yaml`

Set ingress ports for Nodeport example and configure ingress host for local k3s workshop example:  
`source setup-envs.sh`  

validate config:   
`env | grep INGRESS`   

Deploy Flask service:  
`kubectl apply -f flask-deployment-istio.yaml`  

Single test Flask service:  
`source test-flask.sh`  

Single test Istio:  
`source test-istio.sh`  

Load gen Istio:  
`source loadgen.sh`  

Stop loadgen:  
`ctrl-c`  

Cleanup:  
remove k8s examples:  
`source delete-all.sh`

Remove Istio:  
`istioctl x uninstall --purge`
