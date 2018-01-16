from flask import Flask
from flask_mongoengine import MongoEngine
from datetime import datetime


app = Flask(__name__)
app.config ["MONGODB_SETTINGS"] = {
    "db":"dexter-api",
    "host":"mongodb://521.documents.azure.com:10255/dexter-api?ssl=true",
    "username":"521",
    "password":"LY7yPaKzRDADfQr8FUfeGDKChDrcJwXl9IXRbumobKa2gfBJhNu8L157iywowSv1h5vG05wo7K2NbF0u983QGQ=="
}


db = MongoEngine(app)

class Usuarios(db.Document):
    nome = db.StringField()
    email = db.StringField(unique=True)
    data_cadastro = db.DateTimeField(default=datetime.now())

if __name__ == '__main__':
    
    limite = 10
    cont = 1
    while cont < limite:
        cont = cont + 1

        user = Usuarios()
        user.nome = ("Felipe%s" % str(cont))
        user.email = ("moz.felipe%s@gmail.com" % str(cont))
        print(user.nome)
        user.save()
        