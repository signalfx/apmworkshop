from time import sleep
from random import random, seed, randint
import datetime

seed(1)
x=1

while True:
    random_number = randint(0,16777215)
    hex_number = str(hex(random_number))
    hex_number = hex_number[2:]

    now = datetime.datetime.now()

    y=round(random(),1)+.25
    sleep(y)
    printtime = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3]+"Z"
    print(printtime)
#   print('Sleeping: ', y)