"""
A trivial markdown to bbcode converter.

Only supporting what I need in a Simple Machines readme file:

- heading as #, ##, and ###
- ol lists as "- list item"
- code as ```
- italic as _text_
"""
import argparse
import re

def convert(source, target):
    it_pattern_start = re.compile(r'\b_')
    it_pattern_end = re.compile(r'_\b')
    code_pattern = re.compile(r'`(.+)`') # TODO: make sure it's the right thing
    state = None
    for line in source:
        line = line.rstrip()
        if state == 'ul' and line == '':
            line = '[/list]\n'
            state = None
        if line.startswith('- '):
            line = f'[li]{line[2:]}[/li]'
            if state == 'empty_before':
                line = f'\n[list]\n{line}'
                state = 'ul'
        elif line.startswith('# '):
            # line = f'[h1]{line[2:]}[/h1]'
            line = f'[size=6][b]{line[2:]}[/b][/size]'
        elif line.startswith('## '):
            # line = f'[h2]{line[3:]}[/h2]'
            line = f'[size=5][b]{line[3:]}[/b][/size]'
        elif line.startswith('### '):
            # line = f'[h3]{line[4:]}[/h3]'
            line = f'[size=4][b]{line[4:]}[/b][/size]'
        line = re.sub(it_pattern_start, '[i]', line)
        line = re.sub(it_pattern_end, '[/i]', line)
        line = line.replace('```', f'[{"" if state == "empty_before" else "/"}code]')
        line = re.sub(code_pattern, r'[font=Courier][nobbc]\1[/nobbc][/font]', line)
        target.write(line + '\n')
        if line == '':
            if state is None:
                state = 'empty_before'
        elif state == 'empty_before':
            state = None


def main():
    parser = argparse.ArgumentParser(
        prog='md2bbcode',
        description='Convert a md file into a bbcode one.',
    )
    parser.add_argument('source', type=argparse.FileType('r'))
    parser.add_argument('target', type=argparse.FileType('w'))
    args = parser.parse_args()

    convert(args.source, args.target)

if __name__ == '__main__':
    main()
