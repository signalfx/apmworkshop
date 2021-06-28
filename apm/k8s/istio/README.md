Set up Istio:
https://istio.io/latest/docs/setup/getting-started/#install  

`istioctl install --set profile=demo -y`
`kubectl label namespace default istio-injection=enabled`  

Enable Prometheus Metrics:  
`kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.10/samples/addons/prometheus.yaml`

Set ingress ports for Nodeport example and configure ingress host for local k3s workshop example:  
`source setup-env.sh`

validate config: 
`env | grep INGRESS`   

Deploy Flask service:  
`kubectl apply -f flask-deployment.yaml`

Single test Flask service:  
`curl -H "Server: 1" localhost:30001/echo`  

Create Istio Gateway and Virtual Service:  
`kubectl apply -f istio-flask-gateway.yaml`

Single test Istio:  
`curl -s -I -HHost:flask-server.com "http://$INGRESS_HOST:$INGRESS_PORT/echo"`

Load gen Istio:  
`source loadgen.sh`  

Stop loadgen:  
`ctrl-c`

Cleanup:  
`source delete-all.sh`