BEGIN
CREATE DATABASE escola;

-- tabela alunos
CREATE TABLE alunos (
    id serial,
    nome VARCHAR(50),
    email VARCHAR(50)
);

-- lista tabelas
\d
--lista dbs
\l

INSERT INTO alunos 
VALUES ("Felipe", "moz.felipe@gmail.com")

COMMIT;

-- Mysql


CREATE DATABASE escola;
show databases;

USE escola; 
-- cria user + grants
GRANT ALL PRIVILEGES on escola.* TO admin@'localhost' IDENTIFIED BY '1234Linux' WITH GRANT OPTION;
FLUSH PRIVILEGES; 
EXIT


CREATE TABLE clientes(
    id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255),
    email VARCHAR(255)
);