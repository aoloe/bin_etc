#!/usr/bin/python3
import os
import eyed3
import argparse

parser = argparse.ArgumentParser(description='Create a mv.sh file from the tags in all mp3 files in the current directory.')
parser.add_argument('-a', dest='artist', action='store',
   default=None,
   help='artist name')
parser.add_argument('-b', dest='album', action='store',
   default=None,
   help='album tag')
parser.add_argument('-s', dest='separator', action='store',
   default='_-_',
   help='fields separator')
args = parser.parse_args()

files = [f for f in os.listdir('.') if os.path.isfile(f)]
files.sort()
track_count = len(files)
print(track_count)
first = True
for f in files:
    fstring, fextension = os.path.splitext(f)
    if fextension == '.mp3':
        values = fstring.split(args.separator)
        values = [v.replace('_', ' ') for v in values]
        print(values)
        file = eyed3.load(f)
        file.initTag()
        
        i = 0
        if args.artist is None:
            artist = values[i]
            i += 1
        else:
            artist = args.artist
        file.tag.artist = artist
        file.tag.albumartist = artist
        if args.album is None:
            album = values[i]
            i += 1
        else:
            album = args.album
        file.tag.album = album
        file.tag.track_num = (values[i], track_count)
        i += 1
        file.tag.title = values[i]
        if first:
            # TODO: support png images?
            # TODO: look for the first jpg image?
            try:
                with open("cover.jpg", "rb") as img_fp:
                    pass
                    # print(f)
                    # file.tag.images.set(eyed3.id3.frames.ImageFrame.FRONT_COVER, img_fp.read(),  "image/jpeg", "")
            except FileNotFoundError:
                print("could not find the cover.jpg file")
            first = False
        file.tag.save()
