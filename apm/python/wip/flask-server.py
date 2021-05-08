from flask import Flask, render_template, request
from time import sleep
from random import seed, randrange

seed()

app = Flask(__name__)

@app.route('/good-ad')
def good_ad():
    return 'ad success!'

@app.route('/slow-ad')
def slow_ad():
    y = randrange(3,7)
    sleep(y)
    message = "Slooow ad: " + str(y) + " seconds"
    return message

def index(op):
    return render_template('index.html', op=op)

@app.route('/<op>')

def index(op):
    return render_template('index.html', op=op)

@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('index-none.html'), 404

@app.errorhandler(500)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('index-500.html'), 500

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')