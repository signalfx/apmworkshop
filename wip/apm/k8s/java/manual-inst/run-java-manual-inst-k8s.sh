sh ./manual-inst/install-java-otel.sh
# change target URL below to alter the test target
java \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./manual-inst/target/java-app-1.0-SNAPSHOT.jar
