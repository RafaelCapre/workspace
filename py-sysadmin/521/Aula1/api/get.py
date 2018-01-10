#!/usr/bin/python3
import requests
import json

url = 'http://localhost:5000/usuarios/'

response = requests.get(url)

var = json.loads(response.text)

for v in var['usuarios']:
    print(v)