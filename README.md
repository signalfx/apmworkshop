## Splunk Observability Cloud: OpenTelemetry Collector / APM Instrumentation Workshop

### Start Here: [APM Instrumentation Workshop](./apm)  

**Workshop Activities**
- Build a local Ubuntu VM Sandbox on Mac or Windows
- OpenTelemetry Collector and APM Labs
    - Linux Host
        - Set up OpenTelemetry Collector Agent on a Linux Host
        - OpenTelemetry APM Instrumentation on Java, Python, and Node apps
    - Kubernetes (k8s) [Click to start at k8s labs](./apm/k8s)
        - Set up OpenTelemetry Collector Agent on a k8s cluster
        - OpenTelemetry APM Instrumentation on k8s on Java, Python k8s pods
        - Manual APM Instrumentation for Java
        - JVM Metrics
        - Span processing with redaction example
        - APM for Istio service mesh
        - OpenTelemetry Collector configuration / troubleshooting
          - Prometheus scraping and custom metrics
          - Collectd: receive metrics from any platform
          - Troubleshooting the Collector

**Details**
- Audience: existing / trained users of Splunk Observability Cloud  
- APM is for self written apps: (with a focus on microservices) or modern (Java >=8 )
- All examples have source code supplied

#### Disclaimers
- This is not product documentation.
- These examples are unsupported and are for experimentation and educational purposes only.
- Official documentation: https://docs.splunk.com/Observability/