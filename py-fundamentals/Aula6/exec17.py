#!/usr/bin/python3

"""

17 - Classe ser: Crie uma classe que modele uma ser:
Atributos: nome, idade, peso e altura
Métodos: Envelhercer, engordar, emagrecer, crescer.

"""

class Pessoa:
    __nome = None
    __idade = None
    __peso = None
    __altura = None

    def __init__(self, nome, idade, peso, altura):
        self.__nome = nome
        self.__idade = idade
        self.__peso = peso
        self.__altura = altura

    def get_nome(self):
        return self.__nome

    def get_idade(self):
        return self.__idade
    
    def get_peso(self):
        return self.__peso

    def get_altura(self):
        return self.__altura


    def envelhercer(self,idade):
        idade_atual = self.get_idade()
        nova_idade = idade_atual + idade
        self.__idade = nova_idade
        return nova_idade
    
    
    def engordar(self, peso):
        peso_atual = self.get_peso()
        novo_peso = peso + peso_atual
        self.__peso = novo_peso
        return novo_peso


    def emagrecer(self, peso):
        novo_peso =  self.get_peso() - peso
        self.__peso = novo_peso
        return novo_peso


    def crescer(self, altura):
        nova_altura = altura + self.get_altura()
        self.__altura = nova_altura
        return nova_altura

ser = Pessoa("Felipe",31,110,183)

print(
"""
Nome: %s 
Idade: %s anos, 
Peso: %s kilos 
Altura: %s cms
""" %   (
            ser.get_nome(), 
            ser.get_idade(),
            ser.get_peso(),
            ser.get_altura()
        )
    )

ser.crescer(float(input("Quantos cm cresceu:")))
ser.emagrecer(float(input("Quantos kilos emagreceu?")))
ser.engordar(float(input("Quantos kilos engordou?")))
ser.envelhercer(int(input("Quantos anos envelheceu?")))

print("Calulando:....")

print(
"""
Nome: %s 
Nova Idade idade: %s anos, 
Novo Peso: %s kilos 
Nova Altura: %s cms
""" %   (
            ser.get_nome(), 
            ser.get_idade(),
            ser.get_peso(),
            ser.get_altura()
        )
    )

