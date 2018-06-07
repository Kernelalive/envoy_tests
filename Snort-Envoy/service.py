from flask import Flask
from flask import request
import socket
import os
import sys
import requests
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'HELLO'

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)
