from flask import Flask, make_response, request

app = Flask(__name__)
   
@app.route('/echo', methods=['GET', 'POST'])
def echo():
    if request.method == 'POST':
#       print('You posted ')
        return(request.data)
    else:
 #      print('You getted ')
        return(request.data)

if __name__ == '__main__':
    app.run(host='0.0.0.0')