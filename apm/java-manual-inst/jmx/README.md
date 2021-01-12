To enable JMX Metrics when running a Java app:

```
mvn compile exec:exec \
  -Dexec.executable="java" \
  -Dexec.args="-Dcom.sun.management.jmxremote.port=3000 \
  -Dcom.sun.management.jmxremote.authenticate=false \
  -Dcom.sun.management.jmxremote.ssl=false \
  -Dcom.sun.management.jmxremote.rmi.port=3000 \
  -javaagent:signalfx-tracing.jar -cp %classpath sf.main.GetExample"
```
  
Sample SignalFx agent.yaml monitor entry for generic JMX:
```
  - type: collectd/genericjmx
    host: localhost
    port: 3000
    mBeanDefinitions:
      threading:
        objectName: java.lang:type=Threading
        values:
        - type: gauge
          table: false
          instancePrefix: jvm.threads.count
          attribute: ThreadCount
```
