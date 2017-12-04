#!/usr/bin/python3
"""
 19 - FAÇA UM PROGRAMA QUE RECEBA O EMAIL DO ALUNO E R
 ETORNE O NOME E A DATA DE CADASTRO NO FORMATO DD-M-YYYY

"""

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

class color:
   PURPLE = '\033[95m'
   CYAN = '\033[96m'
   DARKCYAN = '\033[36m'
   BLUE = '\033[94m'
   GREEN = '\033[92m'
   YELLOW = '\033[93m'
   RED = '\033[91m'
   BOLD = '\033[1m'
   UNDERLINE = '\033[4m'
   END = '\033[0m'

    
novo_aluno = Aluno(None,None,None)


with open ('cadastro.json', 'r') as f:
    try:
        email = str(input("Digite email a ser buscado:"))
   #     alunos = f.read()
        
        for line in json.loads(f.read()):
            if  email == line["email"]:
                print(
                        color.BOLD + 
                        color.GREEN + 
                        +line["nome"] 
                        + color.END
                      )
                break
        else:
             print(
                    color.BOLD + 
                    color.RED + 
                    "Registro nao encontrado" 
                    + color.END
                    )

    except Exception:
        print (Exception)



