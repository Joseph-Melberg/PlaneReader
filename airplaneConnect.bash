#!/bin/bash
echo "Forming Connection"
while true
do
socat -u TCP:127.0.0.1:30005 TCP:centurionx.net:30004
echo "Looks like we lost connection"
sleep 5
done

