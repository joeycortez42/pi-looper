

# Raspberry Pi Video Looper

Infinitly loop through a directory of video files. DOES NOT support audio, because it uses hello_video's raw H264 decoding. Developed on Raspbian Stretch 2017-11-29.

## Installing
Download the install script:
```
wget https://github.com/nokemono42/pi-looper/install.sh
```

Run the installer:
```
sudo ./install.sh
```

## Configure
Once *hello_video* is compiled and copied to */usr/local/bin*, *nano* will open the *config.txt* file so you can specify which folder the H264 videos will be located.

When done the location is set, press CTRL-O and ENTER to save and CTRL-X to exit.

## Creating videos
For MacOS you can use a tool like ffmpeg for convert mp4 files into raw H264 data.

To convert a single mp4 file:
```
ffmpeg -y -i video.mp4 video.h264
```

Or to loop through a folder of vidoes:

```
#!/usr/bin/env bash

options="-y -i"

for f in `ls | grep ".mp4$" | sed 's/\.mp4$//'`; do
	ffmpeg $options $f.mp4 $f.h264
done
```

## Auto-run on startup
Modify your local start up script:
```
sudo nano /etc/rc.local
```

Before ``exit0`` add:
```
sh /home/pi/pi-looper/pi-looper.sh &
```
When done, press CTRL-O and ENTER to save and CTRL-X to exit.

## Hide startup text
Hide most of the system start up messages:
```
sudo nano /boot/cmdline.txt
```

Disable splash screen on boot:
```
sudo nano /boot/config.txt
```
Add ``disable_splash=1`` at the end of the file.