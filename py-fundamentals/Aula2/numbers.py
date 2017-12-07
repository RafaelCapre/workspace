#!/usr/bin/python3

#https://docs.python.org/3/library/index.html

x = 5
y = 7
s = "4"

#converte string para inteiro
print(type(int(s)))
print(int(s))

#basics
print(x+y)
print(x-y)
print(x*y)
print(x/y)

#floored quocient
print(x//y)

#remained x/y
print (x % y)

#negative
print(-x)

#absolute
print (abs(-1))

#inteiro
print (int(x/y))

#decimal
print (float(x/y))

#conjungate
print((x/y).conjugate())

#power
print(x ** y)


i = 0
while i < 4:
    i += 1
    print(i)
