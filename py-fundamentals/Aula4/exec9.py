#!/usr/bin/python3
# recebe arquivo de ips, checa se é existe no range de ips validos

ip_source = open("ips.txt", "r")
range = ip_source.readlines()
print (range)

i = 0
for i in range:
    i = i.strip("\n")
    octetos = i.split(".")
    if len(octetos) == 4:
        for oc in octetos:
            print(oc)
            if int(oc) < 0 or int(oc) > 255:
                break
        else:        
            with open ("ips_validos.txt", "a+") as fi:
                fi.write(i + "\n")