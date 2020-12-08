mvn compile exec:exec \
  -Dexec.executable="java" \
  -Dexec.args="-javaagent:/opt/splunk-otel-javaagent.jar -cp %classpath sf.main.GetExample"
