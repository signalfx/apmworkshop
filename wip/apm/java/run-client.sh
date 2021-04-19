java \
<<<<<<< HEAD
	-Dexec.executable="java" \
	-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
	-Dotel.resource.attributes=service.name=java-otel-reqs-client \
	-javaagent:/opt/splunk-otel-javaagent.jar \
	-jar ./target/java-app-1.0-SNAPSHOT.jar
=======
-Dexec.executable="java" \
-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
-Dotel.resource.attributes=service.name=java-otel-reqs-client \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
>>>>>>> f96bb59754c3d7868c73e3aa0c654ad859b9f33c
