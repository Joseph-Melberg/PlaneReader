#!/bin/bash
cd $(dirname $BASH_SOURCE)
sleep 60
echo "Forming Connection"
while true
do
./Log.py INFO gen reverseSSH  "Tunnel open attempted: $1:localhost:22"
ssh -N -R $1:localhost:22 jump@jump.centurionx.net
./Log.py INFO gen reverseSSH  "Tunnel closed" 
sleep 60
done

