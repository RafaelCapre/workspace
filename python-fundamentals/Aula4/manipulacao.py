#!/usr/bin/python3
count=1
while count < 10:
    with open ('arq.txt', 'a+') as f:
        f.write({"numero":str(count)})
        count = count + 1 

with open ('arq.txt', 'r') as f:
    print (f.readlines())
