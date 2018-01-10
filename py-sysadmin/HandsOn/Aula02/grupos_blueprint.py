from flask import Blueprint, jsonify, request
from Model import Grupos
import json

grupos = Blueprint('grupos', __name__)

@grupos.route("/grupos/", methods=['POST'])
def grupo_post():
    grupo = request.get_json()

    grupoModel = Grupos()

    for grp in grupo.keys():
        setattr(grupoModel, grp, grupo[grp])
    grupoModel.save()
    return jsonify({'message': 'Grupo cadastrado com sucesso!'})

@grupos.route("/grupos/<id>/", methods=['PUT'])
def grupo_put(id):
    grupo = request.get_json()

    grupoModel = Grupos.objects(id=id).first()

    for grp in grupo.keys():
        setattr(grupoModel, grp, grupo[grp])
    grupoModel.save()
    return jsonify({'message': 'Grupo alterado com sucesso!'})

@grupos.route("/grupos/<id>/", methods=['DELETE'])
def grupo_delete(id):
    grupoModel = Grupos.objects(id=id)
    grupoModel.delete()

    return jsonify({"message": "Grupo removido com sucesso"})
