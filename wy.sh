# sudo apt update
# sudo apt install curl make g++ xorg-dev xdg-utils git

# rm -fr ESPHamClock
# curl -O https://www.clearskyinstitute.com/ham/HamClock/ESPHamClock.zip
# unzip ESPHamClock.zip
# cd ESPHamClock

# put the results of 'xdpyinfo  | grep -oP 'dimensions:\s+\K\S+'' into a variable called SCREEN
SCREEN=$(xdpyinfo | grep -oP 'dimensions:\s+\K\S+')

# the value before 'x' is the SCREEN_WIDTH of the screen
SCREEN_WIDTH=$(echo $SCREEN | cut -d 'x' -f 1)

# the value after 'x' is the SCREEN_HEIGHT of the screen
SCREEN_HEIGHT=$(echo $SCREEN | cut -d 'x' -f 2)

# convert $SCREEN_HEIGHT to an integer
SCREEN_HEIGHT=$(echo $SCREEN_HEIGHT | bc)
SCREEN_WIDTH=$(echo $SCREEN_WIDTH | bc)
echo "===================================================="
echo "SCREEN_WIDTH : $SCREEN_WIDTH"
echo "SCREEN_HEIGHT: $SCREEN_HEIGHT"

#make -j 4 hamclock-800x480
#make -j 4 hamclock-2400x1440
#make -j 4 hamclock-3200x1920

cd ESPHamClock || exit

# select the resolution based on the screen size

APP_WIDTH=3200
APP_HEIGHT=1920

if [ $APP_WIDTH -le $SCREEN_WIDTH ] && [ $APP_HEIGHT -le $SCREEN_HEIGHT ]; then

    echo "$APP_WIDTH <= $SCREEN_WIDTH && $APP_HEIGHT <= $SCREEN_HEIGHT..."
    echo "Making  ${APP_WIDTH}x${APP_HEIGHT}..."
    echo "===================================================="
    # ask user to press enter to continue
    read -p "Press Enter to continue..."
    make -j 4 "hamclock-${APP_WIDTH}x${APP_HEIGHT}"
fi

APP_WIDTH=2400
APP_HEIGHT=1440

if [ $APP_WIDTH -le $SCREEN_WIDTH ] && [ $APP_HEIGHT -le $SCREEN_HEIGHT ]; then

    echo "$APP_WIDTH <= $SCREEN_WIDTH && $APP_HEIGHT <= $SCREEN_HEIGHT..."
    echo "Making  ${APP_WIDTH}x${APP_HEIGHT}..."
    echo "===================================================="
    # ask user to press enter to continue
    read -p "Press Enter to continue..."
    make -j 4 "hamclock-${APP_WIDTH}x${APP_HEIGHT}"
fi

APP_WIDTH=800
APP_HEIGHT=480

if [ $APP_WIDTH -le $SCREEN_WIDTH ] && [ $APP_HEIGHT -le $SCREEN_HEIGHT ]; then

    echo "$APP_WIDTH <= $SCREEN_WIDTH && $APP_HEIGHT <= $SCREEN_HEIGHT..."
    echo "Making  ${APP_WIDTH}x${APP_HEIGHT}..."
    echo "===================================================="
    # ask user to press enter to continue
    read -p "Press Enter to continue..."
    make -j 4 "hamclock-${APP_WIDTH}x${APP_HEIGHT}"
fi

sudo make install

hamclock &
