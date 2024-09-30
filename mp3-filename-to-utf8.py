#!/usr/bin/env python3
import pathlib
"""rename mp3 files with strange unicode codes to the unicode chars"""

def decode(text):
    return text \
        .replace(r'\udce0', 'à') \
        .replace(r'\udce4', 'ä') \
        .replace(r'\udce7', 'ç') \
        .replace(r'\udce9', 'é') \
        .replace(r'\udce8', 'è') \
        .replace(r'\udcfc', 'ü') \
        .replace(r'', '')

for f in pathlib.Path('./').glob('*.mp3'):
    # print(decode(str(f).encode('utf-8', 'backslashreplace').decode('utf-8')))
    f.rename(decode(str(f).encode('utf-8', 'backslashreplace').decode('utf-8')))
