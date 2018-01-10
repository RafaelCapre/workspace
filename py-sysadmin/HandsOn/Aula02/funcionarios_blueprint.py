from flask import Blueprint, jsonify, request
import json

funcionarios = Blueprint('funcionarios', __name__)


@funcionarios.route("/funcionarios/")
def funcionarios_get():
    with open('banco.json', 'r') as f:
        arquivo_json = json.loads(f.read())

    return jsonify(arquivo_json['funcionarios'])


@funcionarios.route("/funcionarios/<id>/")
def funcionario_get(id):
    with open('banco.json', 'r') as f:
        arquivo_json = json.loads(f.read())

    for j in arquivo_json['funcionarios']:
        if j['id'] == int(id):
            return jsonify(j)

    return jsonify({"mensagem": "Funcionario nao encontrado"})


@funcionarios.route("/funcionarios/<id>/dependentes/")
def dependentes_get(id):
    with open('banco.json', 'r') as f:
        arquivo_json = json.loads(f.read())

    for j in arquivo_json['funcionarios']:
        if j['id'] == int(id):
            return jsonify(j['dependentes'])

    return jsonify({"mensagem": "Funcionario nao encontrado"})


@funcionarios.route("/funcionarios/<id>/dependentes/", methods=['POST'])
def dependente_post(id):
    data = request.get_json()

    with open('banco.json', 'r') as f:
        arquivo_json = json.loads(f.read())

    for j in arquivo_json['funcionarios']:
        if j['id'] == int(id):
            j['dependentes'].append({"nome": data['nome'], "idade": data['idade'], "id": int(data['id'])})
            with open('banco.json', 'w') as f:
                f.write(json.dumps(arquivo_json))
            return jsonify({"mensagem": "Cadastrado com sucesso"})

    return jsonify({"mensagem": "Funcionario nao encontrado"})


@funcionarios.route("/funcionarios/<func>/dependentes/<dep>/")
def dependente_get(func, dep):
    with open('banco.json', 'r') as f:
        arquivo_json = json.loads(f.read())

    for funcionario in arquivo_json['funcionarios']:
        if funcionario['id'] == int(func):
            for dependente in funcionario['dependentes']:
                if dependente['id'] == int(dep):
                    return jsonify(dependente)

            return jsonify({"mensagem": "Dependente nao encontrado"})

    return jsonify({"mensagem": "Funcionario nao encontrado"})


@funcionarios.route("/funcionarios/<func>/dependentes/<dep>/", methods=['DELETE'])
def dependentes_delete(func, dep):
    return jsonify({"mensagem": "Funcionario nao encontrado"})
