import redis
from time import sleep
from random import random, seed, randint
import datetime

redis_host = "127.0.0.1"
redis_port = 6379
redis_password = ""

seed(1)
x=1

def hello_redis():
    try:
        r = redis.StrictRedis(host=redis_host, port=redis_port, password=redis_password, decode_responses=True)
        r.set("msg:hello", "Hello Redis!!!")
        msg = r.get("msg:hello")
#       print(msg)
    except Exception as e:
        print(e)

while True:
    random_number = randint(0,16777215)
    hex_number = str(hex(random_number))
    hex_number = hex_number[2:]

    now = datetime.datetime.now()
    hello_redis()

    y=round(random(),1)+.25
    sleep(y)
    print (now.strftime("%Y-%m-%d %H:%M:%S"), " transactionID ", hex_number)
#   print('Sleeping: ', y)
