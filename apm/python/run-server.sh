# set up OTEL env variables
export OTEL_SERVICE_NAME=py-otel-flask-server
export OTEL_RESOURCE_ATTRIBUTES=service.name=py-otel-flask-server,deployment.environment=apm-workshop
export OTEL_EXPORTER_JAEGER_ENDPOINT=http://localhost:9080/v1/trace
export OTEL_TRACES_EXPORTER=jaeger-thrift-splunk
export OTEL_PROPAGATORS=b3multi
#   - name: OTEL_EXPORTER_OTLP_ENDPOINT
#     value: http://$(SPLUNK_OTEL_AGENT):4317
# ensure path is correct
export PATH="$HOME/.local/bin:$PATH"
splk-py-trace python3 flask-server.py