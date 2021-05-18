from flask import Flask, make_response, request

app = Flask(__name__)
   
@app.route('/echo', methods=['GET', 'POST'])
def echo():
    if request.method == 'POST':
        headers = request.headers
        return "You posted: " + str(request.data) + " Request headers: " + str(headers)
    if request.method == 'GET':
        headers = request.headers
        return "You getted: " + str(request.data) + " Request headers: " + str(headers)

if __name__ == '__main__':
    app.run(host='0.0.0.0')