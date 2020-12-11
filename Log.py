#!/usr/bin/env python
import os
import time
import subprocess
import pika
import json
import time
import uuid
import sys
import socket
deviceName = socket.gethostname()
print(str(sys.argv))
severity = sys.argv[1]
title = sys.argv[2]
if(len(title)!=36):
    title = str(uuid.uuid1())


processName = sys.argv[3]
messageText = sys.argv[4]


def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()

credentials = pika.PlainCredentials('log','oldspice')
connection = pika.BlockingConnection(pika.ConnectionParameters('centurionx.net',5672,'/',credentials))
channel = connection.channel()
channel.exchange_declare(exchange='Inter',exchange_type='direct',durable=True)
channel.queue_declare(queue='Reader')
messa = {}

def getMAC(interface='wlan0'):
  # Return the MAC address of the specified interface
  try:
    str = open('/sys/class/net/%s/address' %interface).read()
  except:
    str = "00:00:00:00:00:00"
  return str[0:17]

messa["MAC"] = getMAC()
messa["Severity"] = severity
messa["Title"] = title
messa["DeviceName"] = deviceName
messa["ProcessName"] = processName
messa["FormattedMessage"] = messageText
print(messa)
channel.queue_bind(exchange='Inter',queue='logqueue',routing_key='/log')
channel.basic_publish(exchange='Inter',
                      routing_key='/log',
                      body=str(messa))
connection.close()
