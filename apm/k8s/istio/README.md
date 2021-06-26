Set up Istio:
https://istio.io/latest/docs/setup/getting-started/#install  

`istioctl install --set profile=demo -y`
`kubectl label namespace default istio-injection=enabled`  

Enable Istio to send spans to the OpenTelemetry Collector:  
`istioctl install --set values.global.tracer.zipkin.address=otel-collector.default.svc.cluster.local:9411 --set values.pilot.traceSampling=100`

Set ingress ports for Nodeport example:  

```
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export TCP_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')
```

Configure Ingress Host for local k3s workshop example:   

`export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')`

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