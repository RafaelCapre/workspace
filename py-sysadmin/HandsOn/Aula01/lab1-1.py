import requests
import json

nome = "Rafael Medeiros"
email = 'rafael.medeiros@dexter.com.br'

url = 'http://localhost:5000/usuarios/'
resultados = json.loads(requests.get(url).text)

for u in resultados['usuarios']:
    if u['email'] == email:
        print 'Usuario ja cadastrado'
        exit()

data = json.dumps({"nome": nome, "email": email})
headers = {"Content-Type": "application/json"}

print requests.post(url, data=data, headers=headers).text
