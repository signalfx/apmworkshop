### This lab requires starting from the main [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)

#### Step #1 Open new terminal to your Linux instance (or open new pane in tmux)  

Make sure that you still have the Python Flask server from Workshop Activity #2 running. If you accidentally shut it down follow steps from Workshop #2 to restart the Python Flask server.

Make sure you are in the right directory to start the node.js activities:  

`cd ~/apmworkshop/apm/node`

#### Step #2 Set up your node environment for APM

```
npm init && \
npm install signalfx-tracing
```
During `npm init` you can use all defaults

#### Step #3 Set up environment and run the node app with HTTP.get requests

`source run-client.sh`    

You will see requests printed to the window

#### Step #4 Check OpenTelemetry Collector Statistics to see that spans are being sent

Open a new terminal window to your Linux instance (or use `tmux` and run in separate pane)

`lynx localhost:55679/debug/tracez` will show the metrics and spans being gathered and sent by the Collector.  

Lynx is a text browser that was installed during with the `setup-tools`. Enabling a web browser to access your environment will allow for a full web GUI.  

#### Step #5 Traces / services will now be viewable in the APM dashboard

A new service takes about 90 seconds to register for the first time, and then all data will be available in real time.
Additionally span IDs will print in the terminal where flask-server.py is running.
You can use `ctrl-c` to stop the requests and server any time.

You should now see a Node requests service alongside the Python and Java ones.  

#### Step #6 Where is the auto-instrumentation?

For Node.js, the current auto-instrumentation is based on OpenTracing from Splunk SignalFx. These spans are accepted by the OpenTelmetry Collector.

In `app.js` is a call to initiate an auto-instrumenting tracer from npm package `signalfx-tracing`

`const tracer = require('signalfx-tracing').init()`

This auto-instrumenting tracer must be added to the top of a Node app however no code changes are necessary.  

You can see in the `run-client.sh` how the environment has been set up for OpenTelemtry.

Splunk's autoinstrumentation for node.js is here: https://github.com/signalfx/signalfx-nodejs-tracing

You can now go to the next step of [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)
