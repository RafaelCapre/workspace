from flask import Flask
from flask_mongoengine import MongoEngine
from datetime import datetime


app = Flask(__name__)
app.config ["MONGODB_SETTINGS"] = {
    "db":"dexter-api",
    "host":"mongodb://teste1.documents.azure.com:10255/dexter-api?ssl=true&replicaSet=globaldb",
    "username":"teste1",
    "password":"gqbDqqydUIUpe1Hu9K83Urc3W2GjoRvwPnoJpDuiV6XrDwQztYcoFy7qg7DzwueOAMnDzWBkSBHrXOktkAyrbw=="
}


#uri = "mongodb://teste1:gqbDqqydUIUpe1Hu9K83Urc3W2GjoRvwPnoJpDuiV6XrDwQztYcoFy7qg7DzwueOAMnDzWBkSBHrXOktkAyrbw==@teste1.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
#client = pymongo.MongoClient(uri)
#só existe demo para node.js https://docs.microsoft.com/pt-br/azure/cosmos-db/mongodb-samples

db = MongoEngine(app)

class Users2000(db.Document):
    nome = db.StringField()
    email = db.StringField()
    data_cadastro = db.DateTimeField(default=datetime.now())

if __name__ == '__main__':
    limite = 1000
    cont = 1
    
    print("inicio: " + datetime.ctime(datetime.now()))
    while cont < limite:
        cont = cont + 1
        user = Users2000()
        user.nome = ("Felipe%s" % str(cont))
        user.email = ("felipemoz%s@natura.net" % str(cont))
        user.save()
     
    
    print("fim: " + datetime.ctime(datetime.now()))

    #inicio: Tue Jan 16 17:27:01 2018
    #fim: Tue Jan 16 17:27:29 2018
    #Estimated spend (USD): $0.16 hourly / $3.84 daily.
