#!/usr/bin/python3

x = ["a","b","c"]
print (x)

#position 1
print (x[1])

#concatenate
x2 = ["d", "e","f","g","h"]
x = x + x2
print (x)

#delete #2
del x[2]
print (x)

#insert
x.insert(1, "intruso")
print(x)

print(x.reverse())