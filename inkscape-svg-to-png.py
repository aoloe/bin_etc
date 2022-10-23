#!/usr/bin/python3.6

import os
import sys
import argparse
from subprocess import call

parser = argparse.ArgumentParser(description='Use inkscape to convert a file from svg to png.')
parser.add_argument('file', type=argparse.FileType('r'), nargs='+', default=None, help='SVG file')

args = parser.parse_args()

# print(args.file)
for f in args.file:
    fstring, fextension = os.path.splitext(f.name)

    if not fextension == '.svg':
        parser.print_usage()
        sys.exit()

    pngfile = fstring+'.png'

    # print(f.name)
    # print(pngfile)

    call(['inkscape', '--verb=FitCanvasToDrawing', '--verb=FileSave', '--verb=FileQuit', f.name])
    call(['inkscape', '-z', '--export-dpi=300', f.name, '-e', pngfile])

