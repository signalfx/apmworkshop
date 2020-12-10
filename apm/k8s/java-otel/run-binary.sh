curl -L https://github.com/signalfx/splunk-otel-java/releases/latest/download/splunk-otel-javaagent-all.jar -o /opt/splunk-otel-javaagent.jar
chmod 755 /opt/splunk-otel-javaagent.jar
export OTEL_EXPORTER_JAEGER_SERVICE_NAME=java-otel-reqs-client
# change the endoint env variable in the deployment .yaml to change location of your agent
# change target URL below to alter the test target
java \
-DtargetUrl=https://api.github.com \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
