#!/bin/bash

# set the title of the window to "st current directory"

wmctrl -r :ACTIVE: -N "st ${PWD##*/}"
