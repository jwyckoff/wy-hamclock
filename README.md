# wy-hamclock

Personalize script to easily install and configure hamclock on a new Linux machine.

Size Options:
* hamclock-1600x960
* hamclock-2400x1440
* hamclock-3200x1920


```bash
sudo apt update
sudo apt install curl make g++ xorg-dev xdg-utils

rm -fr ESPHamClock
curl -O https://www.clearskyinstitute.com/ham/HamClock/ESPHamClock.zip
unzip ESPHamClock.zip
cd ESPHamClock

#make -j 4 hamclock-800x480
#make -j 4 hamclock-2400x1440
make -j 4 hamclock-3200x1920

sudo make install

hamclock &
```


## Autostart

```bash
cd ~/ESPHamClock
mkdir -p ~/.config/autostart
cp hamclock.desktop ~/.config/autostart
```
