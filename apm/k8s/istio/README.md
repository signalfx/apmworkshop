Install Splunk Otel Collector in its own namespace:  
`kubectl create namespace splunk-otel-collector`

Follow Data Setup but add:  
`--namespace splunk-otel-collector`  

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

Set ingress ports for Nodeport example and configure ingress host for local k3s workshop example:  
`source setup-env.sh`  

validate config: 
`env | grep INGRESS`   

Deploy Flask service:  
`kubectl apply -f flask-deployment-istio.yaml`  

Single test Flask service:  
`curl -H "Server: 1" localhost:30001/echo`  

Single test Istio:  
`curl -s -I -HHost:flask-server.com "http://$INGRESS_HOST:$INGRESS_PORT/echo"`  

Load gen Istio:  
`source loadgen.sh`  

Stop loadgen:  
`ctrl-c`  

Cleanup:  
`source delete-all.sh`