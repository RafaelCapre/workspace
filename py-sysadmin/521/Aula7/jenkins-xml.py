from lxml import etree
#apt-get install python3-lxml

with open ('jenkins-template.xml', 'r') as f:
    config_xml = f.read()

root = etree.XML(config_xml)

print(root)