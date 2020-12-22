from flask import Flask, make_response, request

app = Flask(__name__)
   
def convert_response(message):
    return 'Hello From Flask Server- you sent: {}\n'.format(message)

@app.route('/echo', methods=['POST'])
@app.route('/echo', methods=['GET'])
def echo():
    message = request.data.decode('utf-8')
    return make_response(convert_response(message))

if __name__ == '__main__':
    app.run(host='0.0.0.0')
