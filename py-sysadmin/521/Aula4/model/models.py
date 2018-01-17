from flask import Flask
from flask_mongoengine import MongoEngine
from datetime import datetime


app = Flask(__name__)
app.config ["MONGODB_SETTINGS"] = {
    "db":"dexter-api",
    "host":"mongodb://521.documents.azure.com:10255/dexter-api?ssl=true",
    "username":"521",
    "password":"OPVm6IedwD6fp1wGV0Yh2DzpX6I7nUWMXuO5EXk55eZGoYGdGiB3cbOZhKSw9ytXwcjS7mCzohgfXJotcp1twA=="
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
        