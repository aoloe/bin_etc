#!/bin/sh
# run octave as terminal program if launched from the terminal and force the gui otherwise

if [ -t 0 ] && terminal=1; then

    /usr/bin/octave --no-gui

else

    /usr/bin/octave --force-gui

fi;
