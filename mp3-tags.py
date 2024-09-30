#!/usr/bin/python3
import os
import eyed3
import argparse
import datetime

files = [f for f in os.listdir('.') if os.path.isfile(f)]
files.sort()

for f in files:
    fstring, fextension = os.path.splitext(f)
    if fextension == '.mp3':
        file = eyed3.load(f)

        # print(f)

        if not hasattr(file, 'tag'):
            print('{} has not tags'.format(f))
            os.exit()

        if hasattr(file.tag, 'images') and len(file.tag.images) > 0:
            print("cover image found")

        artist = file.tag.artist if hasattr(file.tag, 'artist') else '---'
        album = file.tag.album if hasattr(file.tag, 'album') else '---'
        # print(hasattr(file.tag, 'track_num'))
        # print('track_num', file.tag.track_num)
        track = file.tag.track_num[0] if hasattr(file.tag, 'track_num') else 0
        title = file.tag.title if hasattr(file.tag, 'title') else '---'

        duration = file.info.time_secs if hasattr(file, 'info') and hasattr(file.info, 'time_secs') else 0

        # print(artist, album, track, title, datetime)
        filename = 'a: {} / b: {} / n: {:02d} / t: {} ({})'.format(artist, album, track, title, datetime.timedelta(seconds=duration))

        print(filename)
