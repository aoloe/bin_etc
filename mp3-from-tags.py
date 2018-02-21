#!/usr/bin/python3
import os
import eyed3
import argparse

parser = argparse.ArgumentParser(description='Create a mv.sh file from the tags in all mp3 files in the current directory.')
parser.add_argument('-a', dest='artist', action='store',
   default=None,
   help='artist tag')
parser.add_argument('-b', dest='album', action='store',
   default=None,
   help='album tag')
parser.add_argument('-i', dest='image', action='store',
   default=None,
   help='cover image')
args = parser.parse_args()

def normalize(text) :
    text = text.lower()
    for k, v in {' ':'_', '\'': '', '.':'', '!':'', '?':'', '…':''}.items():
        text = str.replace(text, k, v)
    return text

files = [f for f in os.listdir('.') if os.path.isfile(f)]
files.sort()
track_count = len(files)
moves = []
for f in files:
    fstring, fextension = os.path.splitext(f)
    if fextension == '.mp3':
        file = eyed3.load(f)

        if not hasattr(file, 'tag'):
            print('{} has not tags'.format(f))
            os.exit()
        if not moves:
            if args.image:
                # TODO: support png images?
                # TODO: look for the first jpg image?
                try:
                    with open(args.image, "rb") as img_fp:
                        print(args.image)
                        file.tag.images.set(eyed3.id3.frames.ImageFrame.FRONT_COVER, img_fp.read(),  "image/jpeg", "")
                        file.tag.save()
                except FileNotFoundError:
                    print("could not find the cover.jpg file")
            elif hasattr(file.tag, 'images') and len(file.tag.images) > 0:
                print("cover image found")


        artist = file.tag.artist if args.artist is None else args.artist

        album = file.tag.album if args.album is None else args.album
        filename = '{}_-_{}_-_{:02d}_-_{}.mp3'.format(normalize(artist), normalize(album), file.tag.track_num[0], normalize(file.tag.title))


        print(filename)
        moves.append('mv "{}" "{}"'.format(f, filename))

with open('mv.sh', 'w') as f:
    f.write('\n'.join(moves)+'\n')
"""
values = fstring.split('_-_')
values = [v.replace('_', ' ') for v in values]
print(values)
file = eyed3.load(f)
file.initTag()
file.tag.artist = values[0]
file.tag.albumartist = values[0]
file.tag.album = values[1]
file.tag.track_num = (values[2], track_count)
file.tag.title = values[3]
if first:
    # TODO: support png images?
    # TODO: look for the first jpg image?
    try:
        with open("cover.jpg", "rb") as img_fp:
            print(f)
            file.tag.images.set(eyed3.id3.frames.ImageFrame.FRONT_COVER, img_fp.read(),  "image/jpeg", "")
    except FileNotFoundError:
        print("could not find the cover.jpg file")
    first = False
file.tag.save()
"""
