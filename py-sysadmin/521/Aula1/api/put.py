#!/usr/bin/python3
import requests
import json

data = json.dumps({"nome":"Mariazinha2","email":"mariazinha@dexter.com"})
headers = {'content-type':'application/json'}

response = requests.put("http://0.0.0.0:5000/usuarios/7/",data=data,headers=headers)
print(response.text)