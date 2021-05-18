# set up OTEL env variables
export OTEL_SERVICE_NAME=py-otel-flask-server
export OTEL_RESOURCE_ATTRIBUTES=service.name=py-otel-flask-server,deployment.environment=apm-workshop
export OTEL_EXPORTER_OTLP_ENDPOINT=http://127.0.0.1:4317
# ensure path is correct
export PATH="$HOME/.local/bin:$PATH"
splk-py-trace python3 flask-server.py