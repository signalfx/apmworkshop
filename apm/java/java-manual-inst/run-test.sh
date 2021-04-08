sh ./manual-inst/install-java-otel.sh
# change target URL below to alter the test target
java \
-javaagent:/opt/splunk-otel-javaagent.jar \
-Dotel.resource.attributes=service.name=GetExampleService \
-Dotel.exporter.jaeger.service.name=GetExampleService \
-jar ./target/java-app-1.0-SNAPSHOT.jar
