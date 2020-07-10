#!/bin/bash
echo "Forming Connection"

sleep 60
while true
do
autossh -N -R 7000:localhost:22 jbmelberg@centurionx.net
sleep 60
done

