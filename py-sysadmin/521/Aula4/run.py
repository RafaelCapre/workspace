from flask import Flask, render_template, request, redirect
from model.models import Usuarios
import json


app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/usuarios/")
def usuarios():
    usuarios = json.loads(Usuarios.objects().to_json())
    print(usuarios)
    return render_template("usuarios.html", usuarios=usuarios)

@app.route("/usuarios/nome/<nome>/")
def get_user_by_nome(nome):
    usuarios = json.loads(Usuarios.objects(nome=nome).to_json())
    print(usuarios)
    return render_template("usuarios.html", usuarios=usuarios)


@app.route("/usuarios/email/<email>/", methods=['GET','POST'])
def alter_user_by_email(email):
    usuario = Usuarios.objects(email=email).first()

    if request.method == 'POST':
        usuario.email= request.form['email'] 
        usuario.nome = request.form['nome'] #o que vale é < .. name="nome" value="{{usuario.nome}}"

        try:
            usuario.save()
        except Exception as e:
            print(e)
        finally:    
            return redirect('/usuarios/')

    usuario = json.loads(usuario.to_json())
    return render_template("usuarios_busca.html", usuario=usuario)


@app.route("/usuarios/delete/<email>/")
def delete_user_by_email(email):
    print("em deleção")
    usuario = Usuarios.objects(email=email).first()
    
    usuario.delete()
    return redirect('/')

@app.route("/usuarios/inserir/", methods=['GET','POST'])
def insert_user():
    print("em criação")

    if request.method == 'POST':
        usuario = Usuarios()
        usuario.email = request.form['email']
        usuario.nome = request.form['nome']
        
        usuario.save()
        return redirect('/usuarios/')
    
    return render_template("usuarios_inserir.html")


if __name__ == '__main__':
    app.run(debug=True)