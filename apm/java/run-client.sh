export OTEL_EXPORTER_JAEGER_SERVICE_NAME=java-otel-reqs-client
java \
-Dexec.executable="java" \
-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
-Dotel.exporter.jaeger.service.name=java-otel-reqs-client \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
