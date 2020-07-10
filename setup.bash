#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get install autossh dump1090-mutability socat screen -y 
sudo mv /etc/default/dump1090-mutability /etc/default/dump1090-mutability.bak
sudo mv dump1090-mutability /etc/default/dump1090-mutability
crontab -l > mycron
echo "@reboot screen -dmS Connector bash "$PWD"/airplaneConnect.bash" >> mycron
echo "@reboot screen -dmS Reverse bash "$PWD"/reverseSSH.bash" >> mycron
crontab mycron
rm mycron
ssh-keygen
ssh-copy-id jbmelberg@centurionx.net
