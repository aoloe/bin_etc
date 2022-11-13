#!/bin/bash

# use xwininfo to get the id (and name) of a window (click to select)
# use xdotool to resize the window to a specific size

if [[ $# -ne 2 ]]; then
    echo "Usage $0 width height"
    exit 0
fi

w=$1
h=$2

echo "Click on the target window"

info=$(xwininfo)

info_id=`echo "$info" | grep 'Window id:'`
info_w=`echo "$info" | grep 'Width:'`
info_h=`echo "$info" | grep 'Height:'`

if [[ "$info_id" =~ ^.+"Window id: "([^[:space:]]+?)" \""(.+)"\""$ ]]; then
    id="${BASH_REMATCH[1]}"
    title="${BASH_REMATCH[2]}"
fi

# if [[ "$info_w" =~ ^[:blank:]*"Width: "([:digit:]+)$ ]]; then
if [[ "$info_w" =~ "Width: "(.+) ]]; then
    window_w=${BASH_REMATCH[1]}
fi
if [[ "$info_h" =~ "Height: "(.+) ]]; then
    window_h=${BASH_REMATCH[1]}
fi

read -p "Resize \"$title\" ($window_w x $window_h) to $w x $h? [Y / n] " answer

if ! [[ "$answer" == "" || "${answer,,}" == "y" ]]; then
    exit 0
fi

xdotool windowsize $id $w $h
