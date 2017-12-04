import json

aluno = { 
    "nome":"felipe",
    "email":"moz.felipe@gmail.com"
}

string = json.dumps(aluno("email"))
print(aluno)

aluno_string = '{"nome":"teste", "email":"teste@teste"}'
# aspas de dentro sempre duplas


#print (aluno + (json.loads(aluno_string())))
