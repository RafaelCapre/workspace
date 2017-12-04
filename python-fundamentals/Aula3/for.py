frutas = ['pera', 'uva', 'maça']
frutas = ('pera', 'uva', 'maça')

for f in frutas:
    print(f)

alunos = [{
        "nome": "Gabriel",
        "idade": 27,
        "email": "gabriel@gabriel.com",
        "notas": [
            5, 6, 7 ,2
        ]
    },
    {
        "nome": "Jao",
        "idade": 27,
        "email": "jao@jao.com",
        "notas": [
            1, 6, 7 ,6
        ]
    }


]

for a in alunos:
    notas = 0
    for n in a["notas"]:
        notas += n
    
    print("Aluno %s nota %s" % (a['nome'], notas))