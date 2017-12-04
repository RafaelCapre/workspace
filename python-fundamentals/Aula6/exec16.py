#!/usr/bin/python3

"""
16 - Classe Quadrado: Crie uma classe que modele um quadrado:
Atributos: Tamanho do lado
Métodos: Mudar valor do Lado, Retornar valor do Lado e calcular Área;
"""

class Quadrado:
    __altura = None
    __comprimento = None

    def __init__(self,altura,comprimento):
        self.__altura = altura
        self.__comprimento = comprimento


    def set_altura(self, altura):
        self.__altura = altura


    def set_comprimento(self, comprimento):
        self.__comprimento = comprimento


    def get_altura(self):
        return self.__altura


    def get_comprimento(self):
        return self.__comprimento


    def get_area(self):
        altura = self.get_altura()
        comprimento = self.get_comprimento()
        area = altura * comprimento
        return area


retangulo = Quadrado(0,0)

print("Altura: %s " % retangulo.get_altura())
print("Comprimento: %s" % retangulo.get_comprimento())
print("Area Total = %s" % retangulo.get_area())

retangulo.set_altura (float(input("Nova Altura:")))
retangulo.set_comprimento (float(input("Novo Comprimento: ")))
print("Area Total = %s" % retangulo.get_area())
