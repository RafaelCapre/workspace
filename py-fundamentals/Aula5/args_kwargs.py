#!/usr/bin/python3

def soma (*args):
    return(sum(args))

def cadastro(**kwargs):
    print(kwargs)


print(soma(1,2,3,4,5,6))

#sempre usando chave-valor
cadastro(nome="Felipe", email="felipe@felipe")

