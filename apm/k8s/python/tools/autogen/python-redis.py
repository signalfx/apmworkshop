import redis
from time import sleep
from random import random, seed, randint
import datetime
from opentelemetry import trace
import json

redis_host = "redis"
redis_port = 6379
redis_password = ""

seed(1)
x=1

def hello_redis():  # simple redis example that will be picked up by auto-instrumentation
    try:
        r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)
        r.set("msg:hello", "Hello Redis!!!")
        msg = r.get("msg:hello")
#       print(msg)
    except Exception as e:
        print(e)

while True:

    hello_redis()   # redis is picked up by auto-instrumentation   

    random_number = randint(0,16777215)
    hex_number = str(hex(random_number))
    hex_number = hex_number[2:]
    printtime = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3]+"Z"
    log_dict = {'transactionTime': printtime,
                'transactionID': hex_number
                }
    
    tracer = trace.get_tracer(__name__)     # create a manual span for a logging operation called "log"
    with tracer.start_as_current_span("log") as kind=SpanKind.SERVER:
        span.set_attribute("transactionTime", printtime)
        span.set_attribute("transactionID", hex_number)
        print(json.dumps(log_dict))
    
    y=round(random(),1)+.25
    sleep(y)
#   print('Sleeping: ', y)