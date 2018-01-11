#!/usr/bin/python3
#https://microsoft.hackster.io/en-US/kaneda-newton-7/temperature-and-humidity-from-pi-to-power-bi-ed53b0

from azure.servicebus import ServiceBusService
import datetime
from datetime import datetime
import random
import sys
import Adafruit_DHT
import time


key_name ="RootManageSharedAccessKey"
key_value="-yourkeyhere-"
sbs = ServiceBusService("proarchiottest", shared_access_key_name=key_name, shared_access_key_value=key_value)
sbs.create_event_hub('proarchiot2')
print 'Press Ctrl-C to quit.'
while True:
	humidity, temperature = Adafruit_DHT.read_retry(11, 4)
	temp = {"Temperature":float(temperature * 9/5.0 + 32),'Humidity':float(humidity)}
	print(temp)
	sbs.send_event('proarchiot2', {'DeviceID':'UAV1','Temperature':float(temperature * 9/5.0 + 32),'Humidity':float(humidity)})
	time.sleep(5)