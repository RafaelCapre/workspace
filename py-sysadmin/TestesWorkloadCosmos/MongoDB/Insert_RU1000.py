from flask import Flask
from flask_mongoengine import MongoEngine
from datetime import datetime


app = Flask(__name__)
app.config ["MONGODB_SETTINGS"] = {
    "db":"dexter-api",
    "host":"mongodb://521.documents.azure.com:10255/dexter-api?ssl=true",
    "username":"521",
    "password":"pseudosenha-trocar"
}


#uri = "mongodb://teste1:gqbDqqydUIUpe1Hu9K83Urc3W2GjoRvwPnoJpDuiV6XrDwQztYcoFy7qg7DzwueOAMnDzWBkSBHrXOktkAyrbw==@teste1.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
#client = pymongo.MongoClient(uri)
#só existe demo para node.js https://docs.microsoft.com/pt-br/azure/cosmos-db/mongodb-samples

db = MongoEngine(app)

class Usuarios(db.Document):
    nome = db.StringField()
    email = db.StringField()
    data_cadastro = db.DateTimeField(default=datetime.now())

if __name__ == '__main__':
    limite = 1000
    cont = 1
    
    print("inicio: " + datetime.ctime(datetime.now()))
    while cont < limite:
        cont = cont + 1
        user = Usuarios()
        user.nome = ("Felipe%s" % str(cont))
        user.email = ("felipemoz%s@natura.net" % str(cont))
        user.save()
     
    
    print("fim: " + datetime.ctime(datetime.now()))


    #inicio: Tue Jan 16 17:23:57 2018
    #fim: Tue Jan 16 17:24:22 2018
    #Estimated spend (USD): $0.080 hourly / $1.92 daily.



