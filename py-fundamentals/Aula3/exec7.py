#!/usr/bin/python3
usr = "a"
pwd = "a"

while usr == pwd:
    print(ascii("Usuario e senha idênticos"))
    usr = input ("Digite User:")
    pwd = input ("Digite Password:")
else:
    print("User Password definidos")
    exit()


#FAÇA UM PROGRAMA QUE RECEBA UM USUARIO E SENHA. 
#SE O USUARIO FOR IGUAL A SENHA PEÇA NOVAMENTE, 
#SENÃO, ENCERRE O PROGRAMA.