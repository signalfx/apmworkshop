import requests
from time import sleep
from random import random, seed

seed(1)
url = 'http://localhost:5000/echo'
x=1

def pythonrequests():
    payload = {'key': 'value'}
    try:
        r=requests.post(url, params=payload)
        print('posting: ', r.url, ' ', r.text)
    except requests.exceptions.RequestException as err:
        print(err)

while x:
    pythonrequests()
    y = random()
    print('Sleeping: ', round(y,2))
    sleep(round(y,2))
