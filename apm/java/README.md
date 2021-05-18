### This lab requires starting from the main [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)

Please see [Step 1](../workshop-steps/1-prep.md) to prep your environment with Java, maven etc.

#### Step #1 Open new terminal to your Linux instance (or open new pane in tmux)

Make sure that you still have the Python Flask server from Lab #2 running. If you accidentally shut it down follow steps from Workshop #2 to restart the Python Flask server.

Make sure you are in the right directory to start the Java activities:  
`cd ~/apmworkshop/apm/java`

#### Step #2 Download Splunk OpenTelemetry Java Auto-instrumentation to /opt

`source install-java-otel.sh`

#### Step #3 Run the Java example with OKHTTP requests

`source run-client.sh`  
You will see requests printed to the window.

#### Step #4 Traces / services will now be viewable in the APM dashboard

A new service takes about 90 seconds to register for the first time, and then all data will be available in real time.  

Additionally the requests made by Java will print in the terminal where flask-server.py is running.
You can use `ctrl-c` to stop the requests and server any time.

You should now see a new Java requests service alongside the Python one.

<img src="../assets/11-java.png" width="360">  

<img src="../assets/12-javatraces.png" width="360">  

<img src="../assets/13-javaspans.png" width="360">  

#### Step #5 Where is the auto-instrumentation?

In the `run-client.sh` script is the java command:

```
java \
-Dexec.executable="java" \
-Dotel.resource.attributes=service.name=java-otel-client,deployment.environment=apm-workshop \
-Dotel.exporter.otlp.endpoint=http://127.0.0.1:4317 \
-Dsplunk.metrics.endpoint=http://127.0.0.1:9943 \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
```

The `splunk-otel-javaagent.jar` file is the automatic OpenTelemetry instrumentation that will emit spans from the app. No code changes are necessary.

The `otel.` resources set up the service name, environment, and destination to send the JVM metrics and spans.  

Splunk's OpenTelmetry autoinstrumentation for Java is here: https://github.com/signalfx/splunk-otel-java

You can now go to the next step of [APM Instrumentation Workshop](../workshop-steps/3-workshop-labs.md)