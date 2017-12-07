#!/usr/bin/python3
class SeresHumanos:
    altura = None
    peso = None
    idade = 0
    nome = None

    #dumder init = método construtor __init__ reservado e obrigatório.
    def __init__(self, altura, peso,nome):
        self.altura = altura
        self.peso = peso
        self.nome = nome
    
    # ENCAPSULAMENTO
    # __private = exclusivo da classe, só pode ser acessado se 
    # instanciado por publicos e protected
    # _protected = pode ser usado no escopo da classe e herdeiros
    # publico = pode ser acessado e modificado fora da classe
    def andar(self):
        pass

    def falar(self):
        pass

    def comer(self):
        pass


#permite herança horizontal 

class Mulher (SeresHumanos):
    gestante = None

    def __init__(self, gestante, nome, altura, peso):
        super().__init__(altura, peso, nome)
        self.gestante = gestante


objeto = Mulher(True,"Maria",1.70,60)
print (str(objeto.altura) + objeto.nome)





