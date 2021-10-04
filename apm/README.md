## Splunk Observability OpenTelemetry Workshop:
## APM Instrumentation and the OpenTelemetry Collector

### Audience
* Intermediate and advanced developers, devops, and SREs who have already set up their Splunk Observability Cloud account and have tried out integrations and dashboards.
* Skill level should include setting up and troubleshooting Linux and Kubernetes environments as well as deploying applications written in current versions of Java, Python, Node.

### Requirements   
* Prerequisites: completion of [Splunk Observability Workshop](https://signalfx.github.io/observability-workshop/latest/) which trains on using metrics/APM and charts/dashboards/alerts  
* Splunk Observability Cloud Account
* Debian (i.e. Ubuntu) Linux environment with minimum 12G RAM and 20G disk w/ lighweight Kubernetes (Rancher k3s) installed. 

This workshop has a [guide](./workshop-steps/1-prep.md) on how to set up an Ubuntu w/ k3s environment on your desktop via Multipass.  

You can use any Ubuntu or Debian environment and any Kubernetes cluster for the workshop by using the included setup tools.  

### Document Conventions

Variables from your Splunk Observability account are displayed like this: YOURVARIABLEHERE.   
I.e. to change your REALM to `us1` change `api.YOURREALMHERE.signalfx.com` to `api.us1.signalfx.com`  

- k8s = Kubernetes
- k3s = a lightweight Kubernetes from Rancher (https://www.k3s.io)
- signalfx = Splunk Observability domain name/endpoint/technology name
- otel = OpenTelemetry

### Workshop Summary

1. Install Splunk OpenTelemetry (Otel) Collector Agent on an Ubuntu Linux host
2. Exercise APM with host based apps (Java, Python, and Node.js examples) using Otel instrumentation
3. Install Splunk Otel Collector Agent pod on Kubernetes
4. Deploy microservices to Kubernetes with Otel APM instrumentation
5. Configure the Otel collector with various capabilities i.e. Prometheus metrics, metrics tranformation, and span key redaction
6. Troubleshoot the Otel collector

***

### Workshop

Step 1: [Pre-work: Choose/Prepare Your Sandbox Environment and Review Key Concepts](./workshop-steps/1-prep.md)  

Step 2: [Install Splunk OpenTelemetry Collector Agent on an Ubuntu host](./workshop-steps/2-otelagent.md)  

Step 3: [Complete APM Workshop Labs for Hosts / k8s ](./workshop-steps/3-workshop-labs.md)  
APM for Kubernetes Lab only: [start here](./k8s)  

Appendix: [Installing Multipass and k3s / Using tmux](./workshop-steps/4-appendix.md)

Non Kubernetes container examples:  
[AWS ECS EC2/Fargate](misc)