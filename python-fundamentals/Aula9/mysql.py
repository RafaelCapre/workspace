#!/usr/bin/python3
import MySQLdb

con = MySQLdb.connect(
                        host="localhost",
                        user ="admin",
                        passwd="1234linx",
                        db="escola"
)


cur = con.cursor()
try:
    cur.execute(
        "INSERT INTO clientes (nome, endereco) \
        VALUES ('Joao da Silva','rua tal')"
        )
    print("ok")
    
    cur.execute("commit")
    #cur.commit()


except Exception as e:
    print(e)
    cur.execute("rollback")
    #cur.rollback()

try:
    cur.execute("SELECT * FROM clientes")
    clientes = cur.fetchall()
    for a  in clientes:
        print (a)
except Exception as e:
    print(e)

