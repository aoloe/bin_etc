#!/usr/bin/python3.6
import argparse

import urllib.request, json
import re
import sys
import os

parser = argparse.ArgumentParser(description='Get the tracks informations from a Bandcamp album page')
parser.add_argument('url', default=None, help='the album url')
args = parser.parse_args()

def get_url_data(url):
    with urllib.request.urlopen(url) as u:
        return u.read().decode()

def get_file_data(filename):
    with open(filename, 'r') as infile:
        return infile.read()

def put_file_data(filename, data):
    with open(filename, 'w') as outfile:
        outfile.write(data + '\n')

def normalize(text) :
    for k, v in {'?':'', '/':'_'}.items():
        text = str.replace(text, k, v)
    return text

# print('the match between ids and i is not correct fix it...')
# sys.exit()

# data_html = get_url_data('https://soundcloud.com/ikan-hyu/sets/ikan-hyu')
data_html = get_url_data(args.url)

# put_file_data('out.txt', data_html)
# data_html = get_file_data('out.txt')
# sys.exit()
# print(data_html)

a = data_html.find('},"tracks":[{"') + 11
b = data_html.find(',"track_count":', a)

data_snippet = data_html[a:b]
# print('---'+data_snippet+'---')
data_json = json.loads(data_snippet)
# print(data_json)
ids = []
for item in data_json:
    ids.append(str(item['id']))

# print(ids)
# sys.exit()

# pattern_re = re.compile(r'-(\d+)\.mp3')
pattern_re = re.compile(r'(^.+)-(\d+)\.mp3')

moves = []
for filename in [f for f in os.listdir('.') if os.path.isfile(f)] :
    # print(filename)
    match = pattern_re.match(filename)
    if match :
        target = '{:02d}_-_{}.mp3'.format(ids.index(match[2]) + 1, match[1])
        # print(target)
        moves.append('mv "{}" "{}"'.format(filename, target))

with open('mv.sh', 'w') as f:
    f.write('\n'.join(moves)+'\n')
