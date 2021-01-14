mvn compile -X exec:exec \
-Dexec.executable="java" \
-Dexec.args="-Dcom.sun.management.jmxremote.port=3000" \
-Dcom.sun.management.jmxremote.authenticate=false \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.rmi.port=3000 \
-Dotel.exporter.jaeger.endpoint=http://127.0.0.1:9080/v1/trace \
-Dotel.exporter.jaeger.service.name=java-otel-reqs-client \
-Dexec.args="-javaagent:/opt/splunk-otel-javaagent.jar -cp %classpath sf.main.GetExample"
