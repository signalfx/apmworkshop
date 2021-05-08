java \
-Dexec.executable="java" \
-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
-Dotel.resource.attributes=service.name=java-otel-reqs-client,deployment.environment=apm-workshop \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar