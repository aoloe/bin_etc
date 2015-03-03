#!/bin/bash
# http://askubuntu.com/questions/107726/how-to-create-animated-gif-images-of-a-screencast

# Delay before starting
DELAY=10

# Duration and output file
if [ $# -gt 0 ]; then
    D="--duration=$@"
else
    echo Default recording duration 10s to /tmp/recorded.gif
    D="--duration=10 /tmp/recorded.gif"
fi

# xrectsel from https://github.com/lolilolicon/xrectsel
ARGUMENTS=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1

echo Delaying $DELAY seconds. After that, byzanz will start
for (( i=$DELAY; i>0; --i )) ; do
    echo $i
    sleep 1
done
echo "byzanz-record --verbose --delay=0 " ${ARGUMENTS} $D
byzanz-record --verbose --delay=0 ${ARGUMENTS} $D
