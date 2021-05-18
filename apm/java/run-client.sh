java \
-Dexec.executable="java" \
-Dotel.resource.attributes=service.name=java-otel-client,deployment.environment=apm-workshop \
-Dotel.exporter.otlp.endpoint=http://127.0.0.1:4317 \
-Dsplunk.metrics.endpoint=http://127.0.0.1:9943 \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar