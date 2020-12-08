curl -L https://github.com/signalfx/splunk-otel-java/releases/latest/download/splunk-otel-javaagent-all.jar -o /opt/splunk-otel-javaagent.jar
chmod 755 /opt/splunk-otel-javaagent.jar
java \
-DtargetUrl=https://api.github.com \
-javaagent:/opt/splunk-otel-javaagent.jar \
-jar ./target/java-app-1.0-SNAPSHOT.jar
