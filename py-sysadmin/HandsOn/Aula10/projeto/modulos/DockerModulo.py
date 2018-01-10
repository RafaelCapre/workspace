from docker import Client


class DockerModulo:
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

    def startContainer(self, id):
        return self.cli.start(container=id)

    def stopContainer(self, id):
        return self.cli.stop(container=id)

    def createContainer(self, nome, hn, img):
        try:
            container = self.cli.create_container(
                name=nome, hostname=hn, image=img,
                detach=True, stdin_open=True, tty=True
            )
            self.cli.start(container=container.get('Id'))
            return container
        except Exception as e:
            raise Exception(e)

    def removeContainer(self, id):
        self.cli.stop(container=id)
        return self.cli.remove_container(id)

    def inspectContainer(self, container_id):
        try:
            container = self.cli.inspect_container(container_id)
            return container
        except Exception as e:
            raise Exception(e)
