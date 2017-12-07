#!/usr/bin/python3

def sum (x, y):
    return (x+y)

def sub (x,y):
    return (x-y)

def div (x, y):
    return (x/y)

def mult (x, y):
    return (x*y)

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


#Menu Fixo:
menu = """
-----------------------------------------------
Menu:
 1: Soma
 2: Subtacao
 3: Divisao 
 4: Multiplicacao
 9: Sair
----------------------------------------------- 
"""

#Constantes
op_validos = [1,2,3,4,9]

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
                    x = int(input("Digite valor de x:"))
                    y = int(input("Digite valor de y:"))
        
                    if op == 1:
                        result = sum(x,y)
                                            
                    elif op == 2:
                        result = sub(x,y)
        
                    elif op == 3:
                        result = div(x,y)
                                             
                    elif op == 4:
                        result = mult(x,y)
                                         
                    print(color.BOLD + "RESULTADO = " 
                            + str(result) + color.END)
                    print(menu)
                    continue

        print(color.YELLOW + "Opcao Invalida, tente novamente"+ color.END)
        continue           