#!/bin/sh

mvn compile exec:exec \
  -Dexec.executable="java" \
  -Dexec.args="-Dcom.sun.management.jmxremote.port=3000 \
  -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false \
  -Dcom.sun.management.jmxremote.rmi.port=3000 \
  -javaagent:signalfx-tracing.jar -cp %classpath sf.main.GetExample"
