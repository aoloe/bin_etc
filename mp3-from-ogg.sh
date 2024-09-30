#!/bin/bash

for f in *.ogg; do
    echo "$f"
    ffmpeg -i "$f" -ab 320k -map_metadata 0 -id3v2_version 3 "${f[@]/%ogg/mp3}"
done
