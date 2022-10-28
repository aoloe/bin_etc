#!/usr/bin/python3
import os
import eyed3
import argparse
import sys

import urllib.request

parser = argparse.ArgumentParser(description='Create a mv.sh file from the tags in all mp3 files in the current directory.')
parser.add_argument('-a', dest='artist', action='store',
   default=None,
   help='artist name')
parser.add_argument('-b', dest='album', action='store',
   default=None,
   help='album tag')
parser.add_argument('-n', dest='num', action='store',
   default=None,
   help='track number')
parser.add_argument('-t', dest='track', action='store',
   default=None,
   help='track title')
parser.add_argument('-i', dest='cover', action='store',
   default=None,
   help='album cover')
parser.add_argument('files', default=None, nargs='+', help='the file to be set')
args = parser.parse_args()

# TODO: add -i for the cover image (with url or local file)
# TODO: add -n (track numbner) and -t (track title)

# print(args.file)

# print(args)

track_count = len(args.files)
first = True
    
for f in args.files:
    fstring, fextension = os.path.splitext(f)
    if fextension == '.mp3':
        file = eyed3.load(f)
        if not file.tag:
            file.initTag()
        
        if args.artist is not None:
            print('set a')
            file.tag.artist = args.artist
            file.tag.albumartist = args.artist
        if args.album is not None:
            print('set b')
            file.tag.album = args.album
        if args.num is not None:
            print('set n')
            file.tag.track_num = int(args.num)
        if args.track is not None:
            print('set t')
            file.tag.title = args.track
        if args.cover is not None:
            if args.cover.startswith(('http:', 'https:')):
                urllib.request.urlretrieve(args.cover, 'cover.jpg')
                args.cover = 'cover.jpg'
            try:
                with open(args.cover, "rb") as img_fp:
                    file.tag.images.set(eyed3.id3.frames.ImageFrame.FRONT_COVER, img_fp.read(),  "image/jpeg", "")
            except FileNotFoundError:
                print("could not find the coverfile")
        file.tag.save()
