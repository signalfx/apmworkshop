### This lab requires starting from the main [APM Instrumentation Workshop](../3-workshop-labs.md)

#### Step #1 Install SignalFx tracing library and boostrap instrumentation. Make sure you have Python3 installed in advance of these steps.

Do all of these from your ~ directory:

```sudo apt-get -y update
sudo apt install -y python3-pip
python3 -m pip install splunk-opentelemetry flask
export PATH="$HOME/.local/bin:$PATH"
splk-py-trace-bootstrap
```

#### Step #2 Set up environment and run Python Flask server using auto-instrumentation

```
cd ./apmworkshop/apm/python
source setup-server.sh  
splk-py-trace python flask-server.py  
```

You will see the server startup text when this is run.

#### Step #3 Run the client python app via the `sfx-py-trace` command to send POST requests to the Flask server

Open a new terminal window to your Linux instance, set up environment variables, and run the `python-requests.py` client to sent POST requests to the Flask server (or use `tmux` and run in separate pane)

```
cd ./apmworkshop/apm/python
source setup-client.sh  
sfx-py-trace python-requests.py
```

The `python-requests.py` client will make 100,000 calls to the server every 250ms. If it finishes you can run it again.  
You can stop the requests with `ctrl-c`

#### Step #4 Check SignalFx SmartAgent to see that spans are being sent

Open a new terminal window to your Linux instance (or use `tmux` and run in separate pane)

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

Notice **Trace Spans Sent (last minute):   1083**  
This means spans are succssfully being sent to Splunk SignalFx.

#### Step #5 Traces / services will now be viewable in the APM dashboard

A new service takes about 90 seconds to register for the first time, and then all data will be available in real time.
Additionally span IDs will print in the terminal where flask-server.py is running.
You can use `ctrl-c` to stop the requests and server any time.

Try out the uAPM, troubleshooting, and trace views as shown below.

Service map of this python demo  

<img src="../../../assets/vlcsnap-00001.png" /> 

Service dashboard shows application metrics and host correlation (keep scrolling down this dashboard to see more)

<img src="../../../assets/vlcsnap-00002.png" />  
<img src="../../../assets/vlcsnap-00003.png" />  

Click on Troubleshooting to see the map with latency, errors, etc  

<img src="../../../assets/vlcsnap-00005.png" /> 

Click on the Requests and Errors box on right, directly onto the purple Requests graph and you'll be able to see traces- select a trace to see spans

<img src="../../../assets/vlcsnap-00004.png" /> 

In the trace view you can click on spans to see more info and their tags, and sort spans by using Span Performance

<img src="../../../assets/vlcsnap-00006.png" /> 

#### Step #6 Where is the auto-instrumentation?

`sfx-py-trace` is the auto instrumenting function that runs Python3 with the instrumentation that automatically emits spans from the python app. No code changes are necessary.

Splunk's autoinstrumentation for python is here: https://github.com/signalfx/signalfx-python-tracing

#### Step #7 Leave the Flask server running

You'll need need this process for the next client examples in the workshop.  

You can now go to the next step of [APM Instrumentation Workshop Labs](../3-workshop-labs.md)
