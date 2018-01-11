from flask import Flask,jsonify

app = Flask(__name__)

@app.route("/")
def index():
    return "Hello World :D"

@app.route("/usuarios/", methods=["GET"])
def usuarios():
    return jsonify({"mensagem":"Listando todos os usuarios"})

@app.route("/usuarios/<id>/", methods=["GET"])
def usuario_get(id):
    return "Listando o user %s" % id 




if __name__ == '__main__':
    app.run(debug=True)

