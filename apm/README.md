## Splunk Observability Microservices APM Instrumentation Workshop

### Audience / Requirements

Audience:
* Intermediate and advanced developers, devops, and SREs who have already set up their Splunk Observability Cloud account and have tried out integrations and dashboards.
* Skill level should include setting up and troubleshooting Linux and Kubernetes environments as well as deploying modern applications i.e. Java 8, Python, Node.

Requirements:   
1. Splunk Observability Cloud Account
2. Debian (i.e. Ubuntu) Linux environment with minimum 8G RAM and 10G disk w/ lighweight Kubernetes (K3S) installed. 

This workshop has a [guide](./workshop-steps/1-prep.md) on how to set up an Ubuntu w/ K3S environment on your desktop via Multipass.  

You can use any Ubuntu or Debian environment and any Kubernetes cluster for the workshop by using the included setup tools.  

### Document Conventions

Variables from your Splunk Observability account are displayed like this: YOURVARIABLEHERE.   
I.e. to change your REALM to `us1` change `api.YOURREALMHERE.signalfx.com` to `api.us1.signalfx.com`  

:play_or_pause_button: **VIDEO:** will proceed a link to the associated section's video to download (downloading is recommended)  

k8s = Kubernetes
k3s = a lightweight Kubernetes from Rancher (https://www.k3s.io)
signalfx = Splunk Observability domain name/endpoint/technology name

### Workshop Summary

1. Install Splunk OpenTelemetry Collector Agent on a host
2. Run APM with host based apps (Java, Python, and Node.js examples) with OpenTelemetry app instrumentation
4. Exercise apps so tey send spans to the Splunk APM platform
5. Use the Splunk APM platform for visualization and troubleshooting
6. Study the code examples- they use frameworks that the auto-instrumentation picks up. The k8s deployment examples show how to deploy microservices with OpenTelemetry APM.  
   Make sure to watch :play_or_pause_button: **video** demos where indicated.

***

### Workshop

Step 1: [Prepare Your Environment and Review Key Concepts](./workshop-steps/1-prep.md)  

Step 2: [Install Splunk OpenTelemetry Collector Agent on an Ubuntu host](./workshop-steps/2-otelagent.md)  

Step 3: [Complete APM Workshop Labs](./workshop-steps/3-workshop-labs.md)  

Appendix: [Installing Multipass and k3s / Using tmux](./workshop-steps/4-appendix.md)

Non Kubernetes container examples:  
[AWS ECS EC2/Fargate ](misc)