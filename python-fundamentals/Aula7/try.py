#!/usr/bin/python3

try:
    var =1
    if x == 2:
        print("OK")
except ValueError as v:
    print(v)
except NameError as n:
    print("Nome errado")
except IndexError as i:
    print("Index error")



try:
    var = True
    if var:
        raise Exception ("erro encontrado")
    print("Try Concluído")
except Exception as e:
    print(e)

finally:
    print("sempre executarei")

