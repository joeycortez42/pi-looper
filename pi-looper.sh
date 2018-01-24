#!/bin/sh

DIR="$(pwd)"

# Variables
MEDIA_PATH=/home/pi/videos

# External config
if [ -e $DIR/config.txt ]; then
	. $DIR/config.txt
fi

# Hide terminal
setterm --cursor off
setterm --foreground black
setterm --clear all

control_c() {
	echo -en "\nExiting!\n"
	setterm --cursor on
	setterm --foreground white
	setterm --clear all
	exit $?
}

# Trap keyboard interrupt (control-c)
trap control_c INT

# Infinite loop
while true; do
	for f in `ls $MEDIA_PATH | grep ".h264$"`; do
		echo "Playing $f"
		hello_video.bin $MEDIA_PATH/$f
	done
done