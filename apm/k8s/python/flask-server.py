from flask import Flask, make_response, request

app = Flask(__name__)
   
def convert_response(message):
    return format(message)

@app.route('/echo', methods=['GET', 'POST'])
def echo():
    data = request.data
    if request.method == 'POST':
        print ('You posted ')
        return(data)
    else:
        print ('You getted ')
        return(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
