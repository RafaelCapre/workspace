#!/usr/bin/python3

"""
Faça um programa que receba nome+email 
de user e cadastre num db
"""
import MySQLdb
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

class Cliente:
    __nome = None
    __email = None

    def __init__ (self, nome, email):
        self.__nome = nome
        self.__email = email

    def set_cliente (self, nome, email):
        self.__nome = nome
        self.__email = email
    
    def get_nome(self):
        return self.__nome

    def get_email(self):
        return self.__email

    def grava_cliente(self):
        try:
            cur.execute(
                "INSERT INTO clientes (nome, email) \
                VALUES ('%s','%s')" % (self.__nome, self.__email)
                )
            cur.execute("commit")
            print (
                    color.BOLD
                    + color.GREEN 
                    + "Dados inseridos com sucesso"
                    + color.END
                    )
        except Exception as e:
            cur.execute("rollback")
            print (
                    color.BOLD
                    + color.RED 
                    + "Valores incorretos"
                    + color.END
                    )


        def update_cliente(self):
        try:
            cur.execute(
                """
                UPDATE
                    alunos 
                SET 
                    nome 
                VALUES ('%s','%s')""" % (self.__nome, self.__email)
                )
            cur.execute("commit")
            print (
                    color.BOLD
                    + color.GREEN 
                    + "Dados inseridos com sucesso"
                    + color.END
                    )
        except Exception as e:
            cur.execute("rollback")
            print (
                    color.BOLD
                    + color.RED 
                    + "Valores incorretos"
                    + color.END
                    )

    def delete_by_email(email):
        try:
            cur.execute(
                "DELETE FROM clientes \
                WHERE email = ('%s')" % (email)
                )1

            cur.execute("commit")
            print (
                    color.BOLD
                    + color.GREEN 
                    + "Dados excluídos com sucesso."
                    + color.END
                    )
        except Exception as e:
            cur.execute("rollback")
            print (
                    color.BOLD
                    + color.RED 
                    + "Nao encontrados valores"
                    + color.END
                    )

            print (e)


con = MySQLdb.connect(
                        host="localhost",
                        user ="admin",
                        passwd="1234linx",
                        db="escola"
)

cur = con.cursor()
cli = Cliente(None, None)

#Menu Fixo:
menu = """
-----------------------------------------------
Menu:
 1: Inserir Cadastros
 2: Busque Cadastros por e-mail e apaga
 3: Busque Cadastros por e-mail e atualiza nome
 9: Sair
----------------------------------------------- 
"""

#Constantes
op_validos = [1,2,3, 9]
print (menu)

while True:
    try:
        op = int(input("Digite opcao do menu:"))
    except ValueError:
        print(color.YELLOW + "Opcao Invalida, tente novamente"+color.END)
    else:
        if op in op_validos:
                if op == 9:
                    print(color.BOLD + color.RED + "Saindo..."+ color.END)
                    exit()
                else:
                    if op == 1:
                        nome = input("Informe nome completo:")
                        email= input("Informe e-mail:")
                        
                        
                        if email.find("@") == -1:
                            print ("email invalido")
                            email= input("Informe e-mail:")
                        else:
                            cli.set_cliente(nome,email)
                            cli.grava_cliente()

                    if op == 2:
                        email= input("Informe e-mail:")
                                               
                        if email.find("@") == -1:
                            print ("email invalido")
                            email= input("Informe e-mail:")
                        else:
                            cli.delete_by_email(email)


                    if op == 3:
                     pass

                    print(menu)
                    continue


        else:
            print(
                    color.YELLOW 
                    + "Opcao Invalida, tente novamente"
                    + color.END
                )

            continue  
