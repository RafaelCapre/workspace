from docker import Client


cli = Client(base_url="tcp://192.168.205.125:2376",version="auto")


class Docker:

    def __init__(self):
        self.cli = Client(base_url="tcp://192.168.205.125:2376", version="auto")
    
    def get_containers(self, all=True):
        return [ c for c in self.cli.containers(all=all)]

    def create_container(self, name, command, image):
        return self.cli.create_container(
            name=name,
            command=command,
            image=image
    )

    def start_container(self, name):
        return self.cli.start(name)

    def stop_container(self, name):
        return self.cli.stop(name)

    def remove_container(self, name):
        return self.cli.remove_container(name)

    

if __name__ == '__main__':
    obj = Docker()
    for i in obj.get_containers():
        print (i['Names'][0])
