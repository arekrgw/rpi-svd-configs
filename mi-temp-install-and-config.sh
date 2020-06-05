#!/bin/bash

sudo apt install python3 bluez python3-pip -y
echo "y" | sudo pip3 install bluepy

mkdir -p ~/mi-temp
cp ./save-to-file.sh ~/mi-temp
cd ~/mi-temp/
chmod +x save-to-file.sh

sudo wget https://raw.githubusercontent.com/JsBergbau/MiTemperature2/master/LYWSD03MMC.py

n=0

# need an input file with MAC adresses
while read line; do
    echo "[program:mi-temp-$n]
command=python3 ./LYWSD03MMC.py --device $line --round --debounce --name sensor$n --callback save-to-file.sh
directory=/home/pi/mi-temp
autostart=true
autorestart=true
user=pi
" | sudo tee "/etc/supervisor/conf.d/mi-th$n.conf"
n=$((n+1))
done