export OTEL_EXPORTER_JAEGER_SERVICE_NAME=java-otel-reqs-client
mvn compile -X exec:exec \
-Dexec.executable="java" \
-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
-Dexec.args="-javaagent:/opt/splunk-otel-javaagent.jar -cp %classpath sf.main.GetExample"
