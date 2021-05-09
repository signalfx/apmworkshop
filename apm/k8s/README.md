## APM For Kubernetes and Advanced Java Examples

### k8s Prep

Identify your token from the Splunk Observability Cloud Portal: `Organization Settings->Access Tokens`

### Exercise 1: Use the Data Setup Wizard to set up a Splunk OpenTelemetry Collector pod on the k3s cluster

If you have the OpenTelemetry Collector running on a host, remove it at this time:  
`sudo sh /tmp/splunk-otel-collector.sh --uninstall`

<img src="../assets/17-datasetup-k8s.png" width="360">  

**Step 1: Splunk Observability Cloud Portal: `Data Setup->Kubernetes->Add Connection`**  
Choose the following:
| Key | Value |
| ----- | ---- |
| Access Token | Select from list |
| Cluster Name | Your initials-cluster i.e. SL-cluster |
| Provider | Other |
| Distribution | Other |
| Add Gateway | No |
| Log Collection | True |  

And then select `Next`  

`Install Integration` page: copy and paste each step to your shell. The final step will install the OpenTelemetry Collector pod.  

<img src="../assets/18-datasetup-k8sinstall.png" width="360"> 

A result will look like this:  
```
NAME: splunk-otel-collector-1620505665
LAST DEPLOYED: Sat May  8 20:27:46 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

Note the name of the deployment when the install completes i.e.:   `splunk-otel-collector-1620505665`  

If you see any errors with `helm` from the Data Setup Wizard, then run the following and try again:  
```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && \
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
```

**Step 2: Update k3s for Splunk Log Observer:**  
k3s has a different format that standard k8s for logging and we need to update our deployment for this.  
You'll need the Collector deployment from the Data Setup Wizard install.  

You can also dervice this from using `helm list` i.e.:  
```
NAME                                    NAMESPACE       REVISION        UPDATED                                 STATUS       CHART                           APP VERSION
splunk-otel-collector-1620504591        default         1               2021-05-08 20:09:51.625419479 +0000 UTC deployed     splunk-otel-collector-0.25.0  
```
The deployment name would be: `splunk-otel-collector-1620504591`  

Update this deployment with the following:  
```
helm upgrade --reuse-values \
--set splunkAccessToken=YOURTOKENHERE \
--set fluentd.config.containers.logFormatType="cri" \
--set fluentd.config.containers.criTimeFormat="%Y-%m-%dT%H:%M:%S.%Nz" \
YOUROTELDEPLOYMENTHERE \ 
splunk-otel-collector-chart/splunk-otel-collector
``` 

Replacing:
YOURTOKENHERE with your token
YOUROTELDEPLOYMENTHERE with the deployment from step 1

i.e.:

```
helm upgrade --reuse-values \  
--set splunkAccessToken=s9s9d887e7f667w8d9s8a \  
--set fluentd.config.containers.logFormatType="cri" \  
--set fluentd.config.containers.criTimeFormat="%Y-%m-%dT%H:%M:%S.%NZ" \  
splunk-otel-collector-1620504591 \   
splunk-otel-collector-chart/splunk-otel-collector
```

### Exercise 2: Deploy APM for containerized apps: Python and Java

##### Start in `~/apmworkshop/apm/k8s/python` directory

Deploy the Flask server deployment/service and the python-requests pod:  
```
cd ~/apmworkshop/apm/k8s
kubectl apply -f py-deployment.yaml
```
-creates a Flask microservice http server, and a Python-requests pod making requests on Flask

Deploy the Java OKHTTP requests pod:
`kubectl apply -f java-deployment.yaml`

-creates a Java OKHTTP requests pod making requests on Flask

### Exercise 3: Study the results

The APM Dashboard will show the instrumented Python-Requests and Java OKHTTP clients posting to the Flask Server.  
Make sure you select the `apm-workshop` ENVIRONMENT to monitor.

<img src="../assets/19-k8s-apm.png" width="360">  

### Exercise 4: Study the `deployment.yaml` files

Example in Github or:  
```
more ~/apmworkshop/apm/k8s/py-deployment.yaml   
more ~/apmworkshop/apm/k8s/java-deployment.yaml   
```
The .yaml files show the environment variables telling the instrumentation to send spans to the OpenTelemetry Collector.

Normally we use an environment variable pointing to `localhost` on a single host application where the SmartAgent is running. In k8s we have separate pods in a cluster for apps and the Collector.   

The Collector pod is running with <ins>node wide visibility</ins>, so to tell each application pod where to send spans:

```
- name: SPLUNK_OTEL_AGENT
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
- name: OTEL_EXPORTER_JAEGER_ENDPOINT
  value: http://$(SPLUNK_OTEL_AGENT):9080/v1/trace
```

### Exercise 5: TBD View trace spans flowing in the Collector  

`kubectl get pods`

Note the pod name of the `OpenTelemetry Collector` pod i.e.:  
`splunk-otel-collector-1620505665-agent-sw45w`

## Advanced Java Exercises

### Exercise 6: Monitor JVM etrics for a Java container

### Exercise 7:  Manually instrument a Java app and add custom tags

Let's say you have an app that has your own functions and doesn't only use auto-instrumented frameworks- or doesn't have any of them!  
You can easily manually instrument your functions and have them appear as part of a service, or as an entire service.

Example is here:

`cd ~/apmworkshop/apm/k8s/java/manual-inst`  

Deploy an app with ONLY manual instrumentation:

`kubectl apply -f java-reqs-manual-inst.yaml`

When this app deploys, it appears as an isolated bubble in the map. It has all metrics and tracing just like an auto-instrumented app does. 

<img src="../assets/20-k8s-manual.png" width="360">  

Take a look at the traces and their spans to see the manually added values of Message, Logs etc.

<img src="../assets/21-k8s-m-trace.png" width="360">  

You will see the function called ExampleSpan. 

<img src="../assets/22-k8s-m-span1.png" width="360"> 

<img src="../assets/23-k8s-m-span2.png" width="360"> 

Study the [manual instrumentation code example here.](https://github.com/signalfx/apmworkshop/blob/master/apm/k8s/java/manual-inst/src/main/java/sf/main/GetExample.java)

There are two methods shown- the decorator @WithSpan method (easiest), and using the GlobalTracer method (more complicated/powerful)...

Note that this is the most minimal example of manual instrumentation- there is a vast amount of power available in OpenTelemetry- please see [the documentation](https://github.com/open-telemetry/opentelemetry-java-instrumentation) and [in depth details](https://github.com/open-telemetry/opentelemetry-java/blob/master/QUICKSTART.md#tracing)

### Exercise 8: Process Spans with the OpenTelemetry Collector

### Clean up deployments and services

To delete all k8s lab work:  
in `~/apmworkshop/apm/k8s/`  
`source delete-all-k8s.sh`

To delete the Collector from k8s:

`helm list`  
`helm delete YOURCOLLECTORHERE`
i.e. `helm delete splunk-otel-collector-1620505665`  


k3s:
`/usr/local/bin/k3s-uninstall.sh`

This is the last lab of the [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)

After working through the labs, try a nice relaxing game of [Python Trace Invaders](https://github.com/signalfx/apmworkshop/tree/master/apm/python/traceinvaders)