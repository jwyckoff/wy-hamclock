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

# select the resolution based on the screen size

OPTION1_WIDTH=3200
OPTION1_HEIGHT=1920

OPTION2_WIDTH=2400
OPTION2_HEIGHT=1440

OPTION3_WIDTH=1600
OPTION3_HEIGHT=960

OPTION4_WIDTH=800
OPTION4_HEIGHT=480

# ask user to make a choice
echo "Please select the resolution you want to install:"
echo "(Screen is $SCREEN_WIDTH x $SCREEN_HEIGHT)"
echo ""
echo "1. $OPTION1_WIDTH x $OPTION1_HEIGHT"
echo "2. $OPTION2_WIDTH x $OPTION2_HEIGHT"
echo "3. $OPTION3_WIDTH x $OPTION3_HEIGHT"
echo "4. $OPTION4_WIDTH x $OPTION4_HEIGHT"
echo "===================================================="
read -p "Enter your choice [1-4]: " choice
case $choice in
1)
    APP_WIDTH=$OPTION1_WIDTH
    APP_HEIGHT=$OPTION1_HEIGHT
    ;;
2)
    APP_WIDTH=$OPTION2_WIDTH
    APP_HEIGHT=$OPTION2_HEIGHT
    ;;
3)
    APP_WIDTH=$OPTION3_WIDTH
    APP_HEIGHT=$OPTION3_HEIGHT
    ;;
4)
    APP_WIDTH=$OPTION4_WIDTH
    APP_HEIGHT=$OPTION4_HEIGHT
    ;;
*)
    echo "Invalid choice..."
    exit
    ;;
esac

echo "Making  ${APP_WIDTH}x${APP_HEIGHT}..."
echo "===================================================="

make -j 4 "hamclock-${APP_WIDTH}x${APP_HEIGHT}"
sudo make install
hamclock &
exit
