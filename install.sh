#!/bin/sh

# Make sure script is run as root.
if [ "$(id -u)" != "0" ]; then
	echo "\nMust be run as root with sudo! Try: sudo ./install.sh"
	exit 1
fi

echo "\nInstalling dependencies...\n"
apt-get update
apt-get -y install get

git clone https://github.com/nokemono42/pi-looper.git
cd pi-looper

echo "\nInstalling hello_video...\n"
cd pi-hello-video
./rebuild.sh
cd hello_video
make install
cd ../..
rm -rf pi-hello-video

nano config.txt