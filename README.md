

# Raspberry Pi Video Looper

Infinitely loop through a directory of video files. DOES NOT support audio, because it uses hello_video's raw H264 decoding. Developed on Raspbian Stretch 2017-11-29.

## Installing
Download the install script:
```
wget https://raw.githubusercontent.com/nokemono42/pi-looper/master/install.sh
```

Add permissions to execute:
```
chmod +x install.sh
```

Run the installer:
```
sudo ./install.sh
```

## Configure
Once *hello_video* is compiled and copied to */usr/local/bin*, *nano* will open the *config.txt* file so you can specify which folder the H264 videos will be located. Don't worry if the folder doesn't exist yet, you can create it once the installer is done.

When done the location is set, press CTRL-O and ENTER to save and CTRL-X to exit.

## Creating videos
For MacOS you can use a tool like ffmpeg to convert mp4 files into raw H264 data.

To convert a single mp4 file:
```
ffmpeg -y -i video.mp4 video.h264
```

Or to loop through a folder of videos:

```
#!/usr/bin/env bash

options="-y -i"

for f in `ls | grep ".mp4$" | sed 's/\.mp4$//'`; do
	ffmpeg $options $f.mp4 $f.h264
done
```

## Transfering videos
Unless you have a spare Linux machine that can mount the ExtFS partition on the SD Card, it's better to just SSH into your pi. Copy the videos to ``/home/pi/videos`` or your desired location.

## Auto-run on startup
Modify your local start up script:
```
sudo nano /etc/rc.local
```

Before ``exit 0`` add:
```
sh /home/pi/pi-looper/run-looper.sh &
```
When done, press CTRL-O and ENTER to save and CTRL-X to exit. Then reboot whenever you are ready.

# Optional
## Hide startup text
Hide system boot messages:
```
sudo nano /boot/cmdline.txt
```
Replace ``console=tty1`` by ``console=tty3`` to redirect boot messages to the third console. Add ``quiet plymouth.enable=0 logo.nologo`` to disables boot messages, disables messages from Plymouth, and hide the Raspberry Pi logo ub top left corner. When done, press CTRL-O and ENTER to save and CTRL-X to exit.


## Remove Rainbow Screen
Disable initial rainbow box:
```
sudo nano /boot/config.txt
```
Add ``disable_splash=1`` at the end of the file. When done, press CTRL-O and ENTER to save and CTRL-X to exit.

## Disable TTY1
Disable main console login so prompt doesn't show on screen. You can always SSH into your Pi.
```
sudo systemctl disable getty@tty1.service
```