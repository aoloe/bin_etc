#!/usr/bin/env python3

"""
Install -- or update to -- the latest version of VSCodium
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
    # https://restfox.dev/
    response = requests.get(' https://api.github.com/repos/VSCodium/vscodium/releases/latest')
    latest_release = response.json()

    response = requests.get(f'https://api.github.com/repos/VSCodium/vscodium/releases/{latest_release["id"]}/assets', params={'per_page': 100})
    latest_assets = response.json()

    for asset in latest_assets:
        if asset['name'].startswith('VSCodium-linux-x64') and asset['name'].endswith('.tar.gz'):
            # print(asset['browser_download_url'])
            version = asset['name'][19:-7]
            print(f'Updating to {version}')
            vscodium_folder = 'vscodium-'+version

            try:
                Path(vscodium_folder).mkdir(exist_ok=False)
            except FileExistsError:
                print(f'The {vscodium_folder} already exists')
                return

            print(f'Downloading {asset["name"]}...')
            download_file(asset['browser_download_url'], asset['name'], vscodium_folder)

            print(f'Unpacking {asset["name"]}...')
            shutil.unpack_archive(vscodium_folder+'/'+asset['name'], vscodium_folder)
            os.remove(vscodium_folder+'/'+asset['name'])

            try:
                os.unlink('vscodium')
            except FileNotFoundError:
                pass
            os.symlink(vscodium_folder+'/'+'/bin/codium', 'vscodium')

            break

if __name__ == "__main__":
    main()
