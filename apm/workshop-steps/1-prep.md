## APM Preparation

### Prep Step 1: Log in to your SignalFx account to identify token/realm  

Check your [Splunk Signalfx Account](https://login.signalfx.com) (your welcome email has this link) and identify your TOKEN and REALM- these are available in the profile menu (the one on top right with a person icon) in your Splunk SignalFx account.

How to find realm:  
<img src="../../../assets/org.png" width="360" />  

How to find token:  
<img src="../../../assets/token.png" width="360" />  


### Prep Step 2: Create Lab Environment  

Splunk infra monitoring and APM are made for **server environments**.  
This workshop uses **Ubuntu Linux** as the server environment.

You can use any Ubuntu platform- bare metal, VM, or cloud VM.

Required software: java 8, helm, maven, k3s (light k8s), this repo

RedHat and other Linux distributions will work the same- simply change the Debian style commands to fit your distribution.

#### To create a Linux environment on a Mac or PC and install the necessary software components:

##### <ins>Mac</ins>

**#1 Install Brew**
Install [brew package manager](https://brew.sh):  
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` 

Make sure `brew` is fully upgraded: `brew upgrade`

Results should be at least 1.5:
```
$ brew --version
Homebrew 2.6.0
```

**#2 Install Multipass**

We will use [Multipass](https://multipass.run) as a hypervisor for Mac: 

Install Multipass: `brew cask install multipass`

If needed, further instructions are here: https://multipass.run/docs/installing-on-macos

Do one final brew upgrade before spinning up VM: `brew upgrade`

**#3 Launch Ubuntu VM**

Create your VM: `multipass launch -n primary -d 12G -m 6G`

This will download Ubuntu and may take a few minute the first time.

This makes a VM named `primary`

Shell into VM: `multipass shell primary`

You can exit VM by typing `exit` at the command line.

To manage multipass VM:  
`multipass stop primary` stops the VM  
`multipass delete primary` deletes the VM from the hypervisor  
`multipass purge` purges created images but leaves the ubuntu template intace  

**#4 Install software needed for lab**

Make sure you are working in the VM: `multipass shell primary`

Update Ubuntu: `sudo apt-get -y update`

helm: `sudo snap install helm --classic`  
java 8 jdk: `sudo apt install -y openjdk-8-jdk`     
maven: `sudo apt-get -y install maven`  
k3s:
```
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml  
```

<ins>Every time you re-enter a shell you'll need to:</ins>   
```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
sudo chmod 644 /etc/rancher/k3s/k3s.yaml  
```
Verify that you can see the basic pods of k3s: `kubectl get pods --all-namespaces`

See the [Appendix](4-appendix.md) for more info on Multipass and k3s.

**#5 Clone this repo**

Clone this repo: `git clone https://github.com/signalfx/apmworkshop/`

##### <ins>Windows</ins>

Follow Multipass Windows installation instructions: https://multipass.run/docs/installing-on-windows

Skip steps 1 and 2 above and start at step 3

### Prep Step 3: Review KEY SPLUNK APM CONCEPTS

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
