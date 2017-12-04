numeros = []

while len(numeros) < 5:
    numeros.append(int(input("Digite um numero: ")))

print("Minha media é {0}".format(int(sum(numeros))/len(numeros)))