from docker import Client

cli = Client(base_url="tcp://0.0.0.0:2376", version='auto')

class DockerManager:
    def __init__(self):
        try:
            self.cli = Client(base_url="tcp://0.0.0.0:2376", version='auto')
        except Exception as e:
            raise Exception(e)

    def getContainers(self, todos=True):
        try:
            return [ c for c in self.cli.containers(all=todos) ]
        except Exception as e:
            raise Exception(e)

    def createContainer(self, nome, hn):
        try:
            container = self.cli.create_container(
                name=nome, hostname=hn, image="debian",
                detach=True, stdin_open=True, tty=True
            )
            self.cli.start(container=container.get('Id'))
            return container
        except Exception as e:
            raise Exception(e)

    def inspectContainer(self, container_id):
        try:
            container = self.cli.inspect_container(container_id)
            return container
        except Exception as e:
            raise Exception(e)

if __name__ == '__main__':
    try:
        manager = DockerManager()
        for c in manager.getContainers():
            print c
        container = manager.createContainer(
            'nomedocontainer', 'hostnamedocontainer'
        )
    except Exception as e:
        print "Falhou: %s" % e
