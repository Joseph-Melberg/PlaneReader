#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get install autossh dump1090-mutability socat screen -y 
mv /etc/default/dump1090-mutability /etc/default/dump1090-mutability.bak
mv dump1090-mutability /etc/default/dump1090-mutability
echo "@reboot screen -dmS Connector bash "$PWD"airplaneConnect.bash"
