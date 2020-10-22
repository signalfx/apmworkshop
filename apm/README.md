## Splunk Observability Microservices APM Instrumentation Workshop

### Audience And Requirements

Audience: Intermediate and advanced developers, devops, and SREs who have already set up their Splunk SignalFx account and have tried out integrations and dashboards. Skill level should include troubleshooting a Linux and Kubernetes environment.

The term "SignalFx" refers to the Splunk Observability services.

Requirements:   
1. Splunk Observability Account
2. Debian (i.e. Ubuntu) Linux environment with minimum 16G RAM and 8G disk should be ready to try all examples.  
RedHat and other mainstream Linux distributions can be used by translating shell commands from Debian.
3. Kubernetes cluster set up in advance. 
Hints on setting up a minimal Ubunbtu VM and Kubernetes cluster on a local machine are included in the Appendix.

### Document Conventions

Variables from your SignalFx account are displayed like this: YOURVARIABLEHERE.   
I.e. to change your REALM to `us1` change `api.YOURREALMHERE.signalfx.com` to `api.us1.signalfx.com`  

:play_or_pause_button: **VIDEO:** will proceed a link to the associated section's video to download (downloading is recommended)

### Summary Of Steps

1. Review basic [Splunk Observability Quick Start for Infrastructure](https://docs.signalfx.com/en/latest/getting-started/quick-start.html)  
2. Install SignalFx SmartAgent on a host and configure it for APM
3. Instrument your app for APM
4. Exercise app so it send spans to Splunk SignalFx
5. Use the Splunk SignalFx APM platform for visualization, troubleshooting, alerts, and automation
6. Study the code examples- they use frameworks that the auto-instrumentation picks up. The K8S deployment examples show how to build clusters with APM.
   Make sure to watch :play_or_pause_button: **video** demos where indicated.

***

### Workshop

Step 1: [Prepare Your Environment and Review Key Concepts](./1-prep.md)  

Step 2: [Install SmartAgent and Configure for APM](./2-smartagent.md)  

Step 3: [Complete APM Workshop Labs](./3-workshop-labs.md)  

Appendix: [Installing k3s and Using tmux](./4-appendix.md)

Other Example:

[AWS ECS Fargate](./misc/fargate)
