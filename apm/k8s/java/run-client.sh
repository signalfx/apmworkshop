curl -L https://github.com/signalfx/signalfx-java-tracing/releases/latest/download/signalfx-tracing.jar -o /opt/signalfx-tracing.jar
chmod 755 /opt/signalfx-tracing.jar
export SIGNALFX_SERVICE_NAME='java-reqs-client'
export SIGNALFX_ENDPOINT_URL='http://localhost:9080/v1/trace'
mvn compile exec:exec \
  -Dexec.executable="java" \
  -Dexec.args="-javaagent:/opt/signalfx-tracing.jar -cp %classpath sf.main.GetExample"
