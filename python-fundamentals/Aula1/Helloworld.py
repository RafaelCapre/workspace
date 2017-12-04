#!/usr/bin/python3
print("Hello, world!")


#incremento simples
count = 1
limit = 10
while count <= limit:
    print("valor:",count) 
    count = count+1
else:
    print("acabou")


#calculadora tosca
a = 1
b = 1
limit = 10

while b <= limit:
    while a <= limit:
        print(a,"x",b,"=",a*b)
        a = a + 1
    else:
        b = b + 1
        a = 1
        print("_________")
else:
    print ("Calculeira feita" , "\b")



# Fibonacci (lista + input)

limit = int(input("Fibonacci Max: "))

#limit.input()
fibo=[1,1]
for i in range (limit):
    fibo.append(fibo[-1]+fibo[-2])
    print (fibo)



