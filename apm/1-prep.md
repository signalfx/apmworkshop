### APM Preparation

#### Prep Step 1: Log in to your SignalFx account to identify token/realm  

Check your [Splunk Signalfx Account](https://login.signalfx.com) (your welcome email has this link) and identify your TOKEN and REALM- these are available in the profile menu (the one on top right with a person icon) in your Splunk SignalFx account.

How to find realm:  
<img src="../../assets/org.png" width="360" />  

How to find token:  
<img src="../../assets/token.png" width="360" />  


#### Prep Step 2: Ensure you are using the following environment for this workshop  

Linux operating system- examples use Ubuntu. RedHat and other Linux distributions will work the same- simply change the Debian style commands to fit your distribution.

Software present on Linux in advance of workshop:  
`curl`  
`git`  
`helm`  
java 8 jdk (`sudo apt install -y openjdk-8-jdk`)  
maven (`sudo apt-get -y install maven`)  
`tmux` (optional)  

#### Prep Step 3: Review KEY SPLUNK APM CONCEPTS
1. There are two moving parts to APM:    
   **One: Application Spans:** Open standards APM spans emitted by your applications. We offer auto-instrumentation (no code changes) for most languages but you can use any framework/library that emits zipkin, OpenTracing, or [OpenTelemetry](https://opentelemtry.io). The optional [OpenTelemetry Collector](https://github.com/open-telemetry/opentelemetry-collector) can covert between trace formats, process, sample etc.  
   **Two: Instructructure metrics:** Metrics are emitted by an infrastructure agent called [SignalFx SmartAgent](https://docs.signalfx.com/en/latest/integrations/agent/agent-install-methods.html) observing the application's host or container cluster. The infrastructure agent is lightweight, open source, real-time, and designed for microservices, containers, and cloud.   
2. Application spans will be sent to the SignalFx SmartAgent running on a host or K8S pod to correlate APM with host metrics. The SmartAgent then relays the spans to SignalFx where they will be assembled into traces.   
3. The APM spans flow in real time and there is no sampling.  
4. Pre-made default Service Dashboards for APM tracing will appear once spans are received by Splunk Signalfx. The uAPM view has directed troubleshooting. 
5. Environment variables in the user environment and the SmartAgent config `/etc/signalfx/agent.yaml` control the setup of APM:      
`SIGNALFX_ENDPOINT_URL` tells your application where to send spans  
`SIGNALFX_SERVICE_NAME` sets the name of your application in the APM interface  
The workshop contains scripts to set these.

[Return to workshop for next step](../README.md)
