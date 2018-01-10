import json
from lxml import etree
from jenkins_integration import JenkinsManager
from docker_integration import DockerManager

jen = JenkinsManager()

with open("job.json",'r') as f:
    job_json = f.read()

job_json = json.loads(job_json)

with open('job_template.xml', 'r') as f:
    template = f.read()

template = template.replace('repositorio_do_gitlab', str(job_json['repo']))
root = etree.XML(template)

builder = root.find('builders')

for step in job_json['steps']:
    shell_step = etree.Element('hudson.tasks.Shell')
    comando = etree.Element('command')
    com = '%s %s' % (step['command'], ' '.join( step['params']))
    comando.text = "ssh root@192.168.0.2 'docker exec Terminus %s '" % com

    shell_step.append(comando)
    builder.append(shell_step)

jen.createJob(job_json['nome'], etree.tostring(root))
