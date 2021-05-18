java \
-Dexec.executable="java" \
-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
-Dotel.propagators=b3multi \
-Dotel.traces.exporter=jaeger-thrift-splunk \
-Dotel.resource.attributes=service.name=java-otel-client,deployment.environment=apm-workshop \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar