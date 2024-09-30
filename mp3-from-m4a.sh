#!/bin/bash

for f in *.m4a; do
  # avconv -i "$f" -qscale:a 0 "${f[@]/%m4a/mp3}"
  echo "$f"
  ffmpeg -v 5 -y -i "$f" -acodec libmp3lame -ac 2 -ab 192k "${f[@]/%m4a/mp3}"
done
