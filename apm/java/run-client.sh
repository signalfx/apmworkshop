mvn compile exec:exec \
  -Dexec.executable="java" \
  -Dexec.args="-javaagent:/opt/signalfx-tracing.jar -cp %classpath sf.main.GetExample"
