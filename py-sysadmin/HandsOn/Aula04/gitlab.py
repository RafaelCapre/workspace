#-*- coding: utf-8 -*-
import requests
import json

token = "PuQePKrdyhzbdfQ5J--7"
url = "http://gitlab.dexter.com.br/api/v3"

def getUsers():
    global url, token
    return json.loads(requests.get("%s/users?private_token=%s" % (url, token))._content)

def createUser(name, user, pswd, email):
    global url, token
    data = {"name": name, "username": user, "password": pswd, "email": email}
    headers = {"Content_Type": "application/json"}
    return json.loads(requests.post("%s/users?private_token=%s" % (url, token), data=data, headers=headers)._content)

def getProjects():
    global url, token
    return json.loads(requests.get("%s/projects?private_token=%s" % (url, token))._content)

def createWebHook(project_id, hook_url):
    global url, token
    data = {"url": hook_url, "push_events": True}
    return json.loads(requests.post("%s/projects/%s/hooks?private_token=%s" % (url, project_id, token)))
