## APM For Kubernetes and Advanced Java Examples

### K8S Prep

Reminder- anytime you start a new shell in your Multipass environment, make sure the k3s environment variables from the prep are set:
```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && \
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
```

<ins>If you are starting from scratch and only want to do this k8s lab:</ins>

Prep your Debian env with this script: https://raw.githubusercontent.com/signalfx/apmworkshop/master/tools/k8s-only.sh

### Exercise 1: set up the SignalFx SmartAgent as a sidecar pod  

Configure the `~/apmworkshop/apm/k8s/values.yaml` file for your environment.  
This sets up all the elements needed for Splunk APM.
An example file (for reference- do not deploy it) is here: `~/apmworkshop/apm/k8s/values-example.txt`

Values to configure:  
| Value | Description           |
|-------|-----------------------|
|`YOURTOKENHERE`|token from your account|
|`YOURREALMHERE`|your realm from your account i.e. us1|
|`YOURCLUSTERNAMEHERE`|any name you pick to represent the cluster|
|`RELEASEVERSIONHERE`|Use the current SignalFx SmartAgent version in the Helm script below from here: https://github.com/signalfx/signalfx-agent/releases i.e. 5.7.1|
|`sfx-workshop`|If you are in a group- put your initials in fornt of this i.e. `js-sfx-workshop`|

Once `values.yaml` is configured, you can use it with helm to set up the SmartAgent pod:

`helm install -f values.yaml signalfx-agent signalfx/signalfx-agent`

If you see this error "Error: Kubernetes cluster unreachable: Get "http://localhost:8080/version?timeout=32s": dial tcp 127.0.0.1:8080: connect: connection refused" then make sure you set the kube env correctly:

```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && \
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
```

### Exercise 2: Deploy the dockerized versions of OpenTlemetry python flask, python requests, and Java OKHTTP pods

##### Start in `~/apmworkshop/apm/k8s/python` directory

`cd ~/apmworkshop/apm/k8s/python`  

Deploy the flask-server pod:  
`kubectl apply -f flask-deployment.yaml`

Deploy the python requests pod:  
`kubectl apply -f python-requests-pod-otel.yaml`

Deploy the Java OKHTTP requests pod:
```
cd ~/apmworkshop/apm/k8s/java
kubectl apply -f java-reqs-jmx-deployment.yaml
```

### Exercise 3: Study the results

The APM Dashboard will show the instrumented Python-Requests and OpenTelemetry Java OKHTTP clients posting to the Flask Server.  
Make sure you select the ENVIRONMENT to monitor on the selector next to `Troubleshooting` i.e. in image below you can see `sfx-workshop` is selected.

<img src="../../../assets/k8s1.png" width="360">  

### Exercise 4: Study the `deployment.yaml` files

Spans need to be send to the SmartAgent which is running in its own pod- the deployment .yaml files will demonstrate this.

Normally we use an environment variable pointing to `localhost` on a single host application where the SmartAgent is running.

In k8s we have separate pods in a cluster for apps and the SmartAgent.  
The SmartAgent pod is running with <ins>node wide visibility</ins>, so to tell each application pod where to send spans, we use this:

```
            - name: MY_NODE_NAME
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: spec.nodeName
            - name: SIGNALFX_ENDPOINT_URL
              value: http://$(MY_NODE_NAME):9080/v1/trace
```

### Exercise 5: View trace spans flowing in SignalFx Agent pod
`kubectl get pods`

Note the pod name of the `SignalFx Agent` pod

`kubectl exec -it PODNAMEOFSIGNALFXAGENT -- bash signalfx-agent status`  

`signalfx-agent status` will show the metrics and spans being sent by the agent like this:

```
ubuntu@primary:~$ signalfx-agent status
SignalFx Agent version:           5.5.1
Agent uptime:                     1h31m32s
Observers active:                 host
Active Monitors:                  10
Configured Monitors:              10
Discovered Endpoint Count:        8
Bad Monitor Config:               None
Global Dimensions:                {host: primary}
GlobalSpanTags:                   map[]
Datapoints sent (last minute):    370
Datapoints failed (last minute):  0
Datapoints overwritten (total):   0
Events Sent (last minute):        6
Trace Spans Sent (last minute):   1083
Trace Spans overwritten (total):  0
```

Notice `Trace Spans Sent (last minute):   1083` 
This means spans are succssfully being sent to Splunk APM.

## Advanced Java Exercises

### Exercise 6: Monitor JVM etrics for a Java container

Our original deployment `values.yaml` file for Splunk SmartAgent had the following stanza which tells the agent to query the `k8s-java-reqs-client-otel` pod for JVM metrics on port 3000:  
```
monitors:
  - type: collectd/genericjmx
    host: k8s-java-reqs-client-otel
    port: 3000
```

To see a dashboard with the JVM for the Java service, go to `Dashboards->JMX (collectd)->Generic Java Stats` and filter for the service if more than one service is present: `sf_service: client-java-otel-k8s`

You will see a real time dashboard for the enabled JVM metrics as shown below:

<img src="../../../assets/jvm.png" width="360"> 

### Exercise 7:  Manually instrument a Java app and add custom tags

Let's say you have an app that has your own functions and doesn't only use auto-instrumented frameworks- or doesn't have any of them!  
You can easily manually instrument your functions and have them appear as part of a service, or as an entire service.

Example is here:

`cd ~/apmworkshop/apm/k8s/java/manual-inst`  

Deploy an app with ONLY manual instrumentation:

`kubectl apply -f java-reqs-manual-inst.yaml`

When this app deploys, it appears as an isolated bubble in the map. It has all metrics and tracing just like an auto-instrumented app does. 

<img src="../../../assets/manual1.png" width="360"> 

To see your manually instrumented function you need to select the Breakdown menu and break down the spans by Operation. 

<img src="../../../assets/manual2.png" width="360"> 

You will see the function called ExampleSpan. 

<img src="../../../assets/manual3.png" width="360"> 

Study the [manual instrumentation code example here.](https://github.com/signalfx/apmworkshop/blob/master/apm/k8s/java/manual-inst/src/main/java/sf/main/GetExample.java)

There are two methods shown- the decorator @WithSpan method (easiest), and using the GlobalTracer method (more complicated/powerful)...

Note that this is the most minimal example of manual instrumentation- there is a vast amount of power available in OpenTelemetry- please see [the documentation](https://github.com/open-telemetry/opentelemetry-java-instrumentation) and [in depth details](https://github.com/open-telemetry/opentelemetry-java/blob/master/QUICKSTART.md#tracing)

### Exercise 8: Deploy the OpenTelemetry Collector and Process Spans

"The OpenTelemetry Collector offers a vendor-agnostic implementation on how to receive, process and export telemetry data. In addition, it removes the need to run, operate and maintain multiple agents/collectors in order to support open-source telemetry data formats (e.g. Jaeger, Prometheus, etc.) sending to multiple open-source or commercial back-ends."

https://github.com/open-telemetry/opentelemetry-collector

For this workshop, we will install a minimal configuration, as a container, and steer the destination of metrics and spans emitted by the Splunk SmartAgent to the OpenTelemetry Collector deployment, which will then send them to the Splunk Observability Platform.

Once the Collector is receiving and re-transmitting telemetry, it can process, export, convert etc.

Official Splunk docs are [here](https://docs.signalfx.com/en/latest/apm/apm-getting-started/apm-opentelemetry-collector.html).  
Original k8s template on which this lab is based is [here](https://github.com/open-telemetry/opentelemetry-collector-contrib/blob/master/exporter/sapmexporter/examples/signalfx-k8s.yaml).

### Install OpenTelemetry Collector Deployment for Kubernetes - Redact Span Tags

In the Java Manual Instrumenation Example, the ExampleSpans service has a manually created tag called `user.id` that shows unique user IDs from the application. See an example trace with `user.id` highlighted in blue.

<img src="../../../assets/redact0.png" width="360"> 

<img src="../../../assets/redact1.png" width="360"> 

If we want to redact the `user.id`:

`cd ~/apmworkshop/apm/k8s/otel-collector/`

Set up the SFX Environment variables in `otel-redact.yaml` in this stanza:

```     env:
        - name: SFX_REALM
          value: YOURREALMHERE
        - name: SFX_TOKEN
          value: YOURTOKENHERE
```

| Value | Description |
|-------|-------------|
|`YOURREALMHERE`| your realm i.e. US1|
|`YOURTOKENHERE`| your token i.e. av9dd9ckdr9|

Create the OpenTelemetry Collector deployment with redaction processing:  
`kubectl apply -f otel-redact.yaml`  

Tell SmartAgent to send the spans and metrics to the OpenTelemetry Collector deployment:  

```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=http://otel-collector:9943 \
--set traceEndpointUrl=http://otel-collector:7276/v2/trace
```

You will now get dashboards for OpenTelemetry Collector performance in the `Dashboards` section of the UI.

<img src="../../../assets/oteldash1.png" width="360"> 
<img src="../../../assets/oteldash2.png" width="360"> 

Since this interrupts span flow, wait about a minute to examine spans again and check the `user.id` and you will see that it now reads `redacted`

<img src="../../../assets/redact2.png" width="360"> 

The `processors` sections of `otel-redact.yaml.yaml` show how this is done- and full documentation is [here](https://github.com/open-telemetry/opentelemetry-collector/blob/master/processor/README.md)

You will now see the OpenTelemetry Collector's metrics in the Dashboards section of the Observability portal.

### Clean up deployments and services

To delete all k8s lab work:  
in `~/apmworkshop/apm/k8s/`  
`source delete-all-k8s.sh`

To delete the Collector:  

Tell SmartAgent to send the spans and metrics to the Splunk APM service:  

```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=https://ingest.YOURREALMERE.signalfx.com \
--set traceEndpointUrl=https://ingest.YOUREALMHERE.signalfx.com/v2/trace
```
i.e.
```
helm upgrade --reuse-values signalfx-agent signalfx/signalfx-agent \
--set ingestUrl=https://ingest.US1.signalfx.com \
--set traceEndpointUrl=https://ingest.US1.signalfx.com/v2/trace
```

Delete collector k8s components:  
`source delete-otel-collector.sh`

SignalFx Agent:
`helm delete signalfx-agent`  

k3s:
`/usr/local/bin/k3s-uninstall.sh`

This is the last lab of the [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)

After working through the labs, try a nice relaxing game of [Python Trace Invaders](https://github.com/signalfx/apmworkshop/tree/master/apm/python/traceinvaders)
