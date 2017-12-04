#!/usr/bin/python3

import json
from datetime import datetime

class Aluno:
    __nome = None
    __email = None
    __data_cadastro = None


    def __init__(self, nome, email, data_cadastro):
        self.__nome = nome
        self.__email = email
        self.__data_cadastro = data_cadastro

    
    def set_nome (self, nome):
        self.__nome = nome
    
    def set_email (self, email):
        self.__email = email

    def set_data_cadastro (self, data_cadastro):
        self.__data_cadastro

    def get_nome (self):
        return str(self.__nome)

    def get_email(self):
        return str(self.__email)

    def get_data_cadastro (self):
        data = datetime.now().strftime('%d/%b/%y')
        return str(data)

novo_aluno = Aluno(None,None,None)

novo_aluno.set_nome(input("Nome do novo aluno:"))
novo_aluno.set_email(input("Email:"))

print(novo_aluno.get_data_cadastro())

with open ('cadastro.json', 'r') as f:
    try:
        alunos = json.loads(f.read())
    except Exception:
        print (Exception)
    

alunos.append(
                { 
                    "nome": novo_aluno.get_nome(), 
                    "email": novo_aluno.get_email(),
                    "data_cadastro":novo_aluno.get_data_cadastro()
                }       
            )

string = json.dumps(alunos)

with open ('cadastro.json', 'w') as f:
    f.write(string)



