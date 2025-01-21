sudo apt update
sudo apt install curl make g++ xorg-dev xdg-utils git

rm -fr ESPHamClock
curl -O https://www.clearskyinstitute.com/ham/HamClock/ESPHamClock.zip
unzip ESPHamClock.zip
cd ESPHamClock

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

echo ""
cd ESPHamClock

# select the resolution based on the screen size

OPTION1_WIDTH=3200
OPTION1_HEIGHT=1920
echo "Option 1     : $OPTION1_WIDTH x $OPTION1_HEIGHT"

OPTION2_WIDTH=2400
OPTION2_HEIGHT=1440
echo "Option 2     : $OPTION2_WIDTH x $OPTION2_HEIGHT"

OPTION3_WIDTH=800
OPTION3_HEIGHT=480
echo "Option 3     : $OPTION3_WIDTH x $OPTION3_HEIGHT"

APP_WIDTH=$OPTION1_WIDTH
APP_HEIGHT=$OPTION1_HEIGHT

if [ $OPTION1_WIDTH -le $SCREEN_WIDTH ] && [ $OPTION1_HEIGHT -le $SCREEN_HEIGHT ]; then
    APP_WIDTH=$OPTION1_WIDTH
    APP_HEIGHT=$OPTION1_HEIGHT
    echo "$APP_WIDTH <= $SCREEN_WIDTH && $APP_HEIGHT <= $SCREEN_HEIGHT..."
elif [ $OPTION2_WIDTH -le $SCREEN_WIDTH ] && [ $OPTION1_HEIGHT -le $SCREEN_HEIGHT ]; then
    APP_WIDTH=$OPTION2_WIDTH
    APP_HEIGHT=$OPTION2_HEIGHT
    echo "$APP_WIDTH <= $SCREEN_WIDTH && $APP_HEIGHT <= $SCREEN_HEIGHT..."
elif [ $OPTION3_WIDTH -le $SCREEN_WIDTH ] && [ $OPTION3_HEIGHT -le $SCREEN_HEIGHT ]; then
    APP_WIDTH=$OPTION3_WIDTH
    APP_HEIGHT=$OPTION3_HEIGHT
    echo "$APP_WIDTH <= $SCREEN_WIDTH && $APP_HEIGHT <= $SCREEN_HEIGHT..."
else
    echo "No resolution available for this screen size"
    exit
fi

echo "Making  ${APP_WIDTH}x${APP_HEIGHT}..."
echo "===================================================="
# ask user to press enter to continue
read -p "Press Enter to continue..."
make -j 4 "hamclock-${APP_WIDTH}x${APP_HEIGHT}"
sudo make install
hamclock &
exit
