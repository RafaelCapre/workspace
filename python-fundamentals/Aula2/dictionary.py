#!/usr/bin/python3

# JSON =)

x = {"curso":"python",
     "periodo":"noturno",
     "turma":1234,
     "alunos":
            [
                {
                    "nome":"Felipe",
                    "idade": 30
                },
                {
                    "nome":"Joao",
                    "idade": 15
                }

            ]
    }

y = {"curso":"python",
     "periodo":"noturno",
     "turma":3421,
     "alunos":
            [
                {
                    "nome":"Felipe",
                    "idade": 30
                },
                {
                    "nome":"Joao",
                    "idade": 15
                }

            ]
    }

#retornar em string
print(str(x))

#retorna o tamanho do dicionario
print (len(x))

#Somente dado da turma
print(x["turma"])

#Turma, Periodo e Qtde de Alunos
print(x["turma"], x["periodo"],"contem %s" % (len(x)), "alunos")

#imprime alunos
print(x["alunos"])

#retorna o tipo
print (type(x))

#get items, keys, values..
print (x.items())
print (x.keys())
print (x.values())

#compara dois dictionaries
print(cmp(x,y))

#trunca o dicionario
print (x.clear())

