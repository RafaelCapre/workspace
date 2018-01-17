import jenkins

srv = jenkins.Jenkins('http://192.168.205.70:8080')

print(srv.get_version())


print(srv.create_job(
    'Python-Job',
    jenkins.EMPTY_CONFIG_XML
))

srv.build_job('Python-Job')

for u in srv.get_jobs():
    print(u['fullname'])

