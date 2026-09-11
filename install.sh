#!/bin/bash
apt update && apt upgrade -y
apt install -y software-properties-common
add-apt-repository -y ppa:ubuntuhandbook1/ffmpeg7
apt update
apt install ffmpeg -y 
cd /usr/local/src/ffplayout/
wget https://github.com/Cebolomito/ffplayout/releases/download/ffplayout_v2.3.0-1/ffplayout_v2.3.0-1_amd64.deb
dpkg -i ffplayout_v2.3.0-1_amd64.deb
apt install -f -y
