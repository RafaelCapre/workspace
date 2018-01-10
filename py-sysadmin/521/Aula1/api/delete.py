#!/usr/bin/python3
import requests
import json

response = requests.delete("http://0.0.0.0:5000/usuarios/7/")
print(response.text)