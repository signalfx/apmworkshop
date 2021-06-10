# change the endoint env variable in the deployment .yaml to change location of your agent
# change target URL below to alter the test target
java \
-DtargetUrl=http://$SERVER_FLASK_OTEL_K8S_SERVICE_HOST:$SERVER_FLASK_OTEL_K8S_SERVICE_PORT/echo?key=value \
-javaagent:./splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar