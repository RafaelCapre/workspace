#!/usr/bin/python3

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


def gravar (nome, email):
    with open ("cadastro.csv", "a") as f:
        f.write("%s;%s\n" % (nome,email))
        return( color.BOLD + color.GREEN + "Registro inserido" + color.END)

def lista ():
    with open ("cadastro.csv", "r") as f:
        return(f.readlines())

def get_email(search):
    with open('cadastro.csv', 'r') as f:
        for line in f.readlines():
            line = line.strip("\n")
            line = line.split(";")
            if  search == line[1]:
                return(color.BOLD + color.GREEN + line[0] + color.END)
            else:
                return( color.BOLD + color.RED + "Registro nao encontrado" + color.END)


    
#Menu Fixo:
menu = """
-----------------------------------------------
Menu:
 1: Inserir
 2: Lista Cadastros
 3: Busque Cadastros por e-mail
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
                            pass
                            result = gravar(nome,email)     
                            print(result)

                    if op == 2:
                        print(lista())


                    if op == 3:
                        search= input("Busque e-mail:")
                        print(get_email(search))

                    print(menu)
                    continue


        else:
            print(color.YELLOW + "Opcao Invalida, tente novamente"+ color.END)
            continue  