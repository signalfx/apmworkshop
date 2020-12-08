curl -L https://github.com/signalfx/splunk-otel-java/releases/latest/download/splunk-otel-javaagent-all.jar -o /opt/splunk-otel-javaagent.jar
chmod 755 /opt/splunk-otel-javaagent.jar
export SIGNALFX_SERVICE_NAME='k8s-java-otel-reqs-client'
export OTEL_EXPORTER='jaeger'
# change the env variable below to change location of your agent
# export SIGNALFX_ENDPOINT_URL='YOURAGENTADDRESSHERE'
# change target URL below to alter the test target
java \
-DtargetUrl=https://api.github.com \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
