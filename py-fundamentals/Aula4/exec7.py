#!/usr/bin/python3
# Recebe dois numeros soma e coloca o resultado num arquivo
x = int (input("Digite valor de x:"))
y = int (input("Digite valor de y:"))

with open ('soma.txt', 'a+') as soma:
    soma.write("x = %s, y = %s, result = %s \n" % (y,x,x+y))
    print("resultado = %s" % str(x+y))



