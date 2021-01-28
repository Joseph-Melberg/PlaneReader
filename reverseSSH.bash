#!/bin/bash
cd $(dirname $BASH_SOURCE)
sleep 60
echo "Forming Connection"
while true
do
ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -N -R $1:localhost:22 jump@jump.centurionx.net
sleep 60
done

