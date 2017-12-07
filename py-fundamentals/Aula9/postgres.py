#!/usr/bin/python3

import psycopg2

con = psycopg2.connect(
                        "host=localhost \
                        dbname=escola \
                        user=admin \
                        password=4linux"
                        )

cur = con.cursor()
try:
    cur.execute(
        "INSERT INTO alunos (nome, email) \
        VALUES ('Joao da Silva','joao@j.com')"
        )
    print("ok")
    cur.commit()

except Exception as e:
    print(e)
    cur.rollback()


try:
    cur.execute("SELECT * FROM alunos")
    alunos = cur.fetchall()
    for a  in alunos:
        print (a[0])
except Exception as e:
    print(e)


