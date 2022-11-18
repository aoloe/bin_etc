#!/usr/bin/env python3

"""
Install -- or update to -- the latest version of VSCode
"""

import requests
import shutil
from pathlib import Path
import os

def download_file(url, target_file, target_dir):
    filename = target_dir + '/' + target_file
    with requests.get(url, stream=True) as r:
        with open(filename, 'wb') as f:
            shutil.copyfileobj(r.raw, f)

def main():
    # from the public and stable url read the redirection to current download url
    response = requests.head('https://code.visualstudio.com/sha/download?build=stable&os=linux-x64', allow_redirects=True)

    filename = Path(response.url).name
    version = filename[16:-7]
    vscode_folder = 'vscode-' + version

    try:
        Path(vscode_folder).mkdir(exist_ok=False)
    except FileExistsError:
        print(f'The {vscode_folder} already exists')
        return

    print(f'Downloading {filename}...')
    download_file(response.url, filename, './')

    print(f'Unpacking {filename}...')
    shutil.unpack_archive(filename)
    os.remove(filename)
    os.rename('VSCode-linux-x64', vscode_folder)

    try:
        os.unlink('vscode')
    except FileNotFoundError:
        pass
    os.symlink(vscode_folder+'/'+'/bin/code', 'vscode')

if __name__ == "__main__":
    main()
