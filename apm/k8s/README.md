## APM For Kubernetes and Advanced Java Examples

### K8S Prep

You must have a ready Kubernetes cluster for this example.  
A guide to setting up your own sandbox with k3s (light k8s) can be found in: [Step 1](../workshop-steps/1-prep.md)

If you are starting the workshop at this labe, you can execute these steps to prep your environment:    
```
curl -sfL https://get.k3s.io | sh -  && \
sudo chmod 644 /etc/rancher/k3s/k3s.yaml && \
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && \
sudo snap install helm --classic
```

Reminder- anytime you start a new environment / shell, make sure the k3s environment variables from the prep are set:
```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && \
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
```

### Exercise 1: set up the SignalFx SmartAgent as a sidecar pod  

Set up Splunk SignalFx SmartAgent in your k3s cluster:  
```
helm repo add signalfx https://dl.signalfx.com/helm-repo && \
helm repo update
```

Configure the `~/apmworkshop/apm/k8s/values.yaml` file for your environment. This sets up all the elements needed for Splunk APM.
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

### Exercise 2: Deploy the dockerized versions of OpenTlemetry python flask, python requests, and Java OKHTTP pods

##### Start in `~/apmworkshop/apm/k8s/python` directory

Deploy the flask-server pod:  
`kubectl create -f flask-deployment.yaml`

Deploy the python requests pod:  
`kubectl create -f python-requests-pod-otel.yaml`

Deploy the Java OKHTTP requests pod:
```
cd ~/apmworkshop/apm/k8s/java
kubectl create -f java-reqs-jmx-deployment.yaml
```

### Exercise 3: Study the results

The APM Dashboard will show the instrumented Python-Requests and OpenTelemetry Java OKHTTP clients posting to the Flask Server.  
Make sure you select the ENVIRONMENT to monitor on the selector next to `Troubleshooting` i.e. in image below you can see `sfx-workshop` is selected.

<img src="../../../assets/vlcsnap-00007.png" width="360">  

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

Our original deployment of the Splunk SmartAgent had the following stanza which tells the agent to query the `k8s-java-reqs-client-otel` pod for JVM metrics on port 3000:  
```
monitors:
  - type: collectd/genericjmx
    host: k8s-java-reqs-client-otel
    port: 3000
```

To see a dashboard with the JVM for the Java service, go to `Dashboards->JMX (collectd)->Generic Java Stats` and filter for the service if more than one service is present: `sf_service: k8s-java-reqs-client-otel`

You will see a real time dashboard for the enabled JVM metrics as shown below:

<img src="../../../assets/jvm.png" width="360"> 

### Exercise 7: Manually instrumenat a Java app

Let's say you have an app that has your own functions and doesn't only use auto-instrumented frameworks- or doesn't have any of them!  
You can easily manually instrument your functions and have them appear as part of a service, or as an entire service.

Example is here:

`cd ~/apmworkshop/apm/k8s/java/manual-inst`  

Deploy an app with ONLY manual instrumentation:

`kubectl create -f java-reqs-manual-inst.yaml`

When this app deploys, it appears as an isolated bubble in the map. It has all metrics and tracing just like an auto-instrumented app does. 

<img src="../../../assets/maninst.png" width="360"> 

To see your manually instrumented function you need to select the Breakdown menu and break down the spans by Operation. 

<img src="../../../assets/maninst-menu.png" width="360"> 

You will see the function called Manual Span. 

<img src="../../../assets/maninst-breakdown.png" width="360"> 

Study the [manual instrumentation code example here.](https://github.com/signalfx/apmworkshop/blob/master/apm/k8s/java/manual-inst/src/main/java/sf/main/GetExample.java)

Note that this is the most minimal example of manual instrumentation- there is a vast amount of power available in OpenTelemetry- please see [the documentation](https://github.com/open-telemetry/opentelemetry-java-instrumentation) and [in depth details](https://github.com/open-telemetry/opentelemetry-java/blob/master/QUICKSTART.md#tracing)


### Clean up deployments and services

Java:
in `~/apmworkshop/apm/k8s/java/`  
`source delete-java-requests.sh`

in `~/apmworkshop/apm/k8s/java/manual-inst`  
`source delete-java-manual-inst.sh`  

Python:
in: `~/apmworkshop/apm/k8s/python`  
`sh delete-all.sh`  

SignalFx Agent:
`helm delete signalfx-agent`  

k3s:
`/usr/local/bin/k3s-uninstall.sh`

This is the last lab of the [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)
