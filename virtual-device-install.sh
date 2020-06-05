#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y git libssl-dev build-essential curl
cd /home/pi/
git clone https://github.com/lukbek/supla-virtual-device.git
sudo chmod +x install.sh 
./install.sh

filename="supla-virtual-device.cfg"
echo "[GLOBAL]" > $filename
echo "device_name=RPI CZUJNIKI TEMPERATURY" >> $filename
echo "" >> $filename

echo "[SERVER]
host=svr$1.supla.org
protocol_version=10

[LOCATION]
ID=$2
PASSWORD=$3
" >> $filename



if [ "$4" != "" ]; then
for((x=0;x<$4;x++)); do
echo "[CHANNEL_$x]
function=TEMPERATURE_AND_HUMIDITY
state_topic=~/mi-temp/sensor$x
min_interval_sec=15
" >> $filename
done
fi


echo "[program:supla-virtual-device]
command=/home/pi/supla-virtual-device/supla-virtual-device
directory=/home/pi/supla-virtual-device
autostart=true
autorestart=true
user=pi
" | sudo tee "/etc/supervisor/conf.d/supla-virtual-device.conf"