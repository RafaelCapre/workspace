from flask import Flask, jsonify
from usuarios_blueprint import usuarios
from grupos_blueprint import grupos
from funcionarios_blueprint import funcionarios

app = Flask(__name__)
app.register_blueprint(usuarios)
app.register_blueprint(grupos)
app.register_blueprint(funcionarios)

@app.route("/")
def hello():
    return "Hello world"

if __name__ == '__main__':
    app.run(debug=True)
