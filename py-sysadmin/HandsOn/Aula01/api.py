import requests
import json
####### GET
url = 'http://localhost:5000/usuarios/4/'
resultado = json.loads(requests.get(url).text)

for key, value in resultado.iteritems():
    print key, value

####### POST
# url = 'http://localhost:5000/usuarios/'
# data = json.dumps({"nome": "mariazinha", "email": "mariazinha@dexter.com"})
# headers = {"Content-Type": "application/json"}
#
# print requests.post(url, data=data, headers=headers).text
####### PUT
# url = 'http://localhost:5000/usuarios/3/'
# data = json.dumps({"nome": "mariazinha", "email": "4linux@dexter.com"})
# headers = {"Content-Type": "application/json"}
#
# print requests.put(url, data=data, headers=headers).text
####### DELETE
# url = 'http://localhost:5000/usuarios/3/'
# print requests.delete(url).text
