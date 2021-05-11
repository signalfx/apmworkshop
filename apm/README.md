## Splunk Observability Microservices APM Instrumentation Workshop

#### Audience:
* Intermediate and advanced developers, devops, and SREs who have already set up their Splunk Observability Cloud account and have tried out integrations and dashboards.
* Skill level should include setting up and troubleshooting Linux and Kubernetes environments as well as deploying modern applications i.e. Java 8, Python, Node.

#### Requirements:   
* Prerequisites: completion of [Splunk Observability Workshop](https://signalfx.github.io/observability-workshop/latest/) which trains on using metrics/APM and charts/dashboards/alerts  
* Splunk Observability Cloud Account
* Debian (i.e. Ubuntu) Linux environment with minimum 8G RAM and 10G disk w/ lighweight Kubernetes (Rancher k3s) installed. 

This workshop has a [guide](./workshop-steps/1-prep.md) on how to set up an Ubuntu w/ k3s environment on your desktop via Multipass.  

You can use any Ubuntu or Debian environment and any Kubernetes cluster for the workshop by using the included setup tools.  

#### Document Conventions

Variables from your Splunk Observability account are displayed like this: YOURVARIABLEHERE.   
I.e. to change your REALM to `us1` change `api.YOURREALMHERE.signalfx.com` to `api.us1.signalfx.com`  

:play_or_pause_button: **VIDEO:** will proceed a link to the associated section's video to download (downloading is recommended)  

k8s = Kubernetes
k3s = a lightweight Kubernetes from Rancher (https://www.k3s.io)
signalfx = Splunk Observability domain name/endpoint/technology name

#### Workshop Summary

1. Install Splunk OpenTelemetry Collector Agent on a host
2. Run APM with host based apps (Java, Python, and Node.js examples) using OpenTelemetry / OpenTracing app instrumentation
4. Exercise apps to send spans to the Splunk APM platform
5. Use the Splunk APM platform for visualization and troubleshooting
6. Study the code examples to learn how they use frameworks picked up by the auto-instrumentation. The k8s shows shows how to deploy microservices with OpenTelemetry APM. 

Make sure to watch :play_or_pause_button: **video** demos where indicated.

***

### Workshop

Step 1: [Pre-work: Choose/Prepare Your Sandbox Environment and Review Key Concepts](./workshop-steps/1-prep.md)  

Step 2: [Install Splunk OpenTelemetry Collector Agent on an Ubuntu host](./workshop-steps/2-otelagent.md)  

Step 3: [Complete APM Workshop Labs for Hosts / k8s ](./workshop-steps/3-workshop-labs.md)  
APM for Kubernetes Lab only: [start here](./k8s)  

Appendix: [Installing Multipass and k3s / Using tmux](./workshop-steps/4-appendix.md)

Non Kubernetes container examples:  
[AWS ECS EC2/Fargate ](misc)
