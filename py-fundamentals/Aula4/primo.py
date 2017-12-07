#!/usr/bin/python3
#numero primo
import os

numero = 2
c = 1
p = 0
primos=[1]

while True:
    try:
        limite = int(input("Limite (nao abuse): "))
    except Exception:
        print("Valores incorretos")
    else:
        break

os.remove("primos.csv")

with open ("primos.csv", "a") as f:
    f.write("%s;"%c)

while numero < limite:
    i = numero -1
    while i > 1:
        if numero % i == 0: 
            break
        i -= 1
        c += 1
    else:
       primos.append (numero)
       
       with open ("primos.csv", "a") as f:
           f.write("%s;" % numero)
       p += 1
    numero += 1

print ("Primos: "  + str(primos))
print ("Foram encontrados %d numeros primos." % p)
print ("Foram necessarias %d comparacoes." % c)