from flask import Flask, render_template
app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/usuarios/")
def usuarios():
    usuarios = [
        {
            "id": 1,
            "nome": "Felipe",
            "email": "felipe@felipemoz.com.br"
        },
        {
            "id":2,
            "nome": "Felipe",
            "email": "felipe@felipemoz.com.br"
        }
    ]

    return render_template("usuarios.html", usuarios=usuarios)

if __name__ == '__main__':
    app.run(debug=True)