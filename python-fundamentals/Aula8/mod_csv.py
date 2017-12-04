import csv
with open ('alunos.csv', 'r') as csvfile:
    arquivo = csv.reader(csvfile, delimiter=';')


mode = input('write/append? (w/a):')
i =1
while i < 10:
    i += 1
    with open ('alunos.csv', mode) as csvfile:
        arquivo = csv.writer(csvfile, delimiter=';')
        arquivo.writerow(['joao', 'joao@joao.com', i])

    with open ('alunos.csv', 'r') as csvfile:
        print(csvfile.readlines())
