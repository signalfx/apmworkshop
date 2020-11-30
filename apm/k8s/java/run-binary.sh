curl -L https://github.com/signalfx/signalfx-java-tracing/releases/latest/download/signalfx-tracing.jar -o /opt/signalfx-tracing.jar
chmod 755 /opt/signalfx-tracing.jar
export SIGNALFX_SERVICE_NAME='k8s-java-reqs-client'
export SIGNALFX_ENDPOINT_URL='http://localhost:9080/v1/trace'
java -DtargetUrl=https://api.github.com -jar ./target/java-app-1.0-SNAPSHOT.jar
