sh ./manual-inst/install-java-otel.sh
# change target URL below to alter the test target
java \
-DtargetUrl=http://localhost:5000/echo?key=value \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
