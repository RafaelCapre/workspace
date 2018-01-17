#!/usr/bin/python3
import requests
import json

class Gitlab:
    
    token = 'private_token=y5BAhu9Tdmi84XjSY2yR'
    base_url = 'http://192.168.205.133'

    def get_projects(self):
        return json.loads(requests.get("%s/api/v3/projects?%s" % (self.base_url,self.token)).text)

    def get_users(self):
        return json.loads(requests.get("%s/api/v3/users?%s" % (self.base_url,self.token)).text)

    def new_user(self, data):
        return json.loads(requests.post("%s/api/v3/users?%s" % (self.base_url,self.token), data=data).text)

    def new_project(self, data):
        return json.loads(requests.post("%s/api/v3/projects?%s" % (self.base_url,self.token), data=data).text)

if __name__ == '__main__':
    obj = Gitlab()

    obj.new_user (
            {
                "name":"Felipe2",
                "email":"moz.felipe@gmail.com",
                "username":"fmoz",
                "password": "4linux123"
            }
        )

    obj.new_project(
        { 
            "name":"projeto beta"
        }
    )


    for i in obj.get_projects():
        print(i['name'])

    for i in obj.get_users():
        print(i['name'], '|' ,i['username'])

    
