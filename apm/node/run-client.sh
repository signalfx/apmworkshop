export SIGNALFX_SERVICE_NAME=node-otel-client
export SIGNALFX_ENDPOINT_URL=http://localhost:9080/v1/trace
export SIGNALFX_SPAN_TAGS=deployment.environment:apm-workshop
node app.js