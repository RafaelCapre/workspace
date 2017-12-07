#!/usr/bin/python3


var = "Hello, World"
lista = ["a","b","c"]

#lower
print (var.lower())

#upper
print (var.upper())

#replace
print (var.replace("l", "x"))

#retona o caracter na posição 3
print (var[3])

#Qtde de Caracateres na cadeia
print (len(var))

#Qtde de vezes que aparece a letra t
print (var.count("o"))

#Primeira letra em maísculo
print (var.lower().title())

#Busca posição da 
#primeira vez que aparece letra "o"
print (var.find("o"))

#Transforma lista em string
print ("".join(lista))

#Transforma string em lista 
#com caracter delimitado
print (var.split(","))

#
# H  E  L  L  O
# 1  2  3  4  5
#-5 -4 -3 -2 -1
#
#slice/crop
print (var[2:5])
print (var[-4])

#Escreve ao contrário
print (var[::-1])

#Pega os últimos 3 caracteres
#de forma invertida
print(var[-3:])






