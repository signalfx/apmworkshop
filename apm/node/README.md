### This lab requires starting from the main [APM Instrumentation Workshop](https://github.com/slernersplunk/splunkobservability/blob/master/apm/README.md)

#### Step #1 Open new terminal to your Linux instance (or open new pane in tmux)  

Make sure that you still have the Python Flask server from Workshop Activity #2 running. If you accidentally shut it down follow steps from Workshop #2 to restart the Python Flask server.

Make sure you are in the right directory to start the node.js activities:  

`cd ~/splunkobservability/apm/node`

#### Step #2 Set up your node environment for APM

```
sudo apt-get install -y nodejs npm
npm init
npm install signalfx-tracing
```
During `npm init` you can use all defaults

#### Step #3 Set up environment and run the node app with HTTP.get requests

```
source setup-client.sh  
node app.js
```

You will see requests printed to the window

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

You should now see a Node requests service alongside the Python and Java ones.  

#### Step #6 Where is the auto-instrumentation?

In `app.js` is a call to initiate an auto instrumenting tracer from npm package `signalfx-tracing`

`const tracer = require('signalfx-tracing').init()`

This auto-instrumenting tracer must be added to the top of a Node app however no code changes are necessary.  

Splunk's autoinstrumentation for node.js is here: https://github.com/signalfx/signalfx-nodejs-tracing

You can now go to the next step of [APM Instrumentation Workshop](../3-workshop-labs.md)
