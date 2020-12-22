import requests
from time import sleep
from random import random
from random import seed

seed(1)
url = 'http://localhost:5000/echo'
x=1

def pythonrequests():
    try:
        requests.post(url, data = {'key': 'value'})
    except requests.exceptions.RequestException as err:
        print(err)

while x:
    pythonrequests()
    y = random()
    print("Posting: ", url, " Sleeping: ", round(y,2))
    sleep(y)
