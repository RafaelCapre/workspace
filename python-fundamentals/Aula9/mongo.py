#!/usr/bin/python3

from pymongo import MongoClient

client = MongoClient('127.0.0.1')
db = client['escola']

# INSERIR DOCUMENTO NO MONGO
db.aluno.insert(
    {
        "nome": "Joao da Silva",
        "email": "joao@joao.com.br",
    }
)

# BUSCAR ALUNO ESPECIFICO
aluno = db.aluno.find({"email": "gabriel@gabriel.com.br"})
for a in aluno:
    print(a)

# COMPARAR IDS NO MONGO
from bson.objectid import ObjectId
alunos = db.aluno.find({})
for a in alunos:
    if ObjectId('5a1ecf542a2cd623581dd5e8') == a['_id']:
        print("AGORA SIM")

# ADICIONAR CAMPO EM DOCUMENTO QUE JA EXISTE
db.aluno.update(
    {"email": "joao@joao.com.br"},
    {
        "$set": {
            "etnia": "indio"
        }
    }
)

# ALTERAR CAMPO NO DOCUMENTO
# db.aluno.update(
#     {"email": "joao@joao.com.br"},
#     {
#         "$set": {
#             "nome": "Joao de Souza"
#         }
#     }
# )

# ALTERAR CAMPO ESPECIFICO DENTRO DE SUBDOCUMENTOS
db.aluno.update(
    {"email": "joao@joao.com.br"},
    {
        "$set": {
            "cursos.0.nome": "JAVA AVANCADO"
        }
    }
)