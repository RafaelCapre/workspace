#!/usr/bin/python3

"""
15 - Classe Bola: Crie uma classe que modele uma bola:
Atributos: Cor, circunferência, material
Métodos: trocaCor e mostraCor
"""


class Bola:
    __cor = None
    __circunferencia = None
    __material = None

    def __init__ (self, cor, circunferencia, material):
        self.__cor = cor
        self.__circunferencia = circunferencia
        self.__material = material

    def get_cor (self):
        return self.__cor

    def set_cor (self, cor):
        self.__cor = cor 

objeto = Bola(None,None,None)

nova_cor = input("Digite Nova Cor: ")
objeto.set_cor(nova_cor)

print(objeto.get_cor())