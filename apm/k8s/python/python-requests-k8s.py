import requests
from time import sleep
from random import random
from random import seed

seed(1)
url = 'http://flask-server:5000/echo'
x=1

def pythonrequests():
    try:
        requests.post(url, data = {'key': 'value'})
    except requests.exceptions.RequestException as err:
        print(err)

while x:
    pythonrequests()
    y = random()*2
    sleep(y)
