from prometheus_client import start_http_server, Summary, Gauge
import random
import time

# Create a metric to track time spent and requests made.
REQUEST_TIME = Summary('request_processing_seconds', 'Time spent processing request')

# Set Up Gauge
g = Gauge('CustomGauge', 'Example Custom Gauge')

# Decorate function with metric.
@REQUEST_TIME.time()
def process_request(t):
    """A dummy function that takes some time."""
    time.sleep(t)
    g.set(17)

if __name__ == '__main__':
    # Start up the server to expose the metrics.
    start_http_server(9090)
    # Generate some requests.
    while True:
        process_request(random.random())
