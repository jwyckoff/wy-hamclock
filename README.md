# wy-hamclock

Personalize script to easily install and configure hamclock on a new Linux machine.

Size Options:

| Option | Width | Height |
| ------ | ----- | ------ |
| 1      | 3200  | 1920   |
| 2      | 2400  | 1440   |
| 3      | 1600  | 960    |
| 4      | 800   | 480    |

## Setup

```bash
 git clone https://github.com/jwyckoff/wy-hamclock.git $HOME/wy-hamclock && bash $HOME/wy-hamclock/wy.sh
```


## Autostart

```bash
cd ~/ESPHamClock
mkdir -p ~/.config/autostart
cp hamclock.desktop ~/.config/autostart
```
