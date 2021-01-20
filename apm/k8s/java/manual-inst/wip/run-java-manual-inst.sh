sh ./manual-inst/install-java-otel.sh
# change target URL below to alter the test target
java \
-DtargetUrl=http://$SERVER_FLASK_OTEL_SERVICE_HOST:$SERVER_FLASK_OTEL_SERVICE_PORT/echo?key=value \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./manual-inst/target/java-app-1.0-SNAPSHOT.jar
