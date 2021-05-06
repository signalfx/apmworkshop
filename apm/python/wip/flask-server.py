from flask import Flask, render_template

app = Flask(__name__)

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