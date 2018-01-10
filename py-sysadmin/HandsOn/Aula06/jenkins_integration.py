import jenkins
from lxml import etree


class JenkinsManager:
    def __init__(self):
        try:
            self.server = jenkins.Jenkins("http://jenkins.dexter.com.br:8080/")
        except Exception as e:
            raise Exception(e)

    def getVersion(self):
        try:
            return self.server.get_version()
        except Exception as e:
            raise Exception(e)

    def createJob(self, name, xml):
        try:
            # INSERINDO URL DO REPOSITORIO GIT
            # with open('job_template.xml', 'r') as f:
            #     template = f.read().replace('repositorio_do_gitlab', 'http://gitlab.dexter.com.br')
            #
            # # MANIPULANDO XML
            # root = etree.XML(template)
            # builder = root.find("builders")
            #
            # shell_step = etree.Element("hudson.tasks.Shell")
            # comando = etree.Element("command")
            # comando.text = "echo 'Echoando'"
            # shell_step.append(comando)
            # builder.append(shell_step)

            return self.server.create_job(name, xml)
        except Exception as e:
            raise Exception(e)

    def jobRun(self, nome):
        return self.server.build_job(nome)

if __name__ == '__main__':
    try:
        jenkins_manager = JenkinsManager()
        # print jenkins_manager.getVersion()
        # jenkins_manager.createJob('JOB')
        jenkins_manager.jobRun('JOB-AULA')
    except Exception as e:
        print e
