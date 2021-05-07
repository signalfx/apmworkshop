## Splunk Observability Microservices APM Instrumentation Workshop

### Audience And Requirements

Audience: Intermediate and advanced developers, devops, and SREs who have already set up their Splunk Observability Cloud account and have tried out integrations and dashboards. Skill level should include setting up and troubleshooting Linux and Kubernetes environments as well as deploying modern applications i.e. Java 8, Python, Node.

Requirements:   
1. Splunk Observability Cloud Account
2. Debian (i.e. Ubuntu) Linux environment with minimum 16G RAM and 28G disk  
This workshop has a [guide](./workshop-steps/1-prep.md) on how to set up an Ubuntu environment on your desktop via Multipass.
3. Kubernetes cluster set up in advance in your Ubuntu environment.

### Document Conventions

Variables from your Splunk Observability account are displayed like this: YOURVARIABLEHERE.   
I.e. to change your REALM to `us1` change `api.YOURREALMHERE.signalfx.com` to `api.us1.signalfx.com`  

:play_or_pause_button: **VIDEO:** will proceed a link to the associated section's video to download (downloading is recommended)

### Workshop Summary

1. Review basic [Splunk Observability Guide for Infrastructure](https://docs.splunk.com/Observability/infrastructure/infrastructure.html#nav-Set-up-Infrastructure-Monitoring)  
2. Install Splunk OpenTelemetry Collector Agent on a host
3. Instrument your app for OpenTelemetry APM
4. Exercise app so it send spans to the Splunk APM platform
5. Use the Splunk APM platform for visualization, troubleshooting, alerts, and automation
6. Study the code examples- they use frameworks that the auto-instrumentation picks up. The k8s deployment examples show how to build clusters with APM.  
   Make sure to watch :play_or_pause_button: **video** demos where indicated.

***

### Workshop

Step 1: [Prepare Your Environment and Review Key Concepts](./workshop-steps/1-prep.md)  

Step 2: [Install Splunk OpenTelemetry Collector Agent](./workshop-steps/2-smartagent.md)  

Step 3: [Complete APM Workshop Labs](./workshop-steps/3-workshop-labs.md)  

Appendix: [Installing Multipass and k3s / Using tmux](./workshop-steps/4-appendix.md)

Non Kubernetes container examples:  
[AWS ECS EC2 and Fargate ](misc)
