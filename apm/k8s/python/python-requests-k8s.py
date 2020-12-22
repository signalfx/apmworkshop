import requests
from time import sleep
from random import random, seed

seed(1)
url = 'http://flask-server:5000/echo'
x=1

def pythonrequests():
    try:
        r=requests.post(url)
        print(r.text)
    except requests.exceptions.RequestException as err:
        print(err)

while x:
    pythonrequests()
    y = random()*2
    print("Posting: ", url, " Sleeping: ", round(y,2))
    sleep(y)
