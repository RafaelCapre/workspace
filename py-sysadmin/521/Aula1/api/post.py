#!/usr/bin/python3
import requests
import json

data = json.dumps({"nome":"Felipe","email":"felipe@4linux.com.br"})
headers = {'content-type':'application/json'}

response = requests.post("http://0.0.0.0:5000/usuarios/",data=data,headers=headers)
print(response.text)