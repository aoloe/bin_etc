#!/usr/bin/env python3

from pathlib import Path
import fileinput
import re

def main():
    cwd = Path.cwd()

    main_file = Path(cwd) / 'lib/main.dart'
    pubspec_file = Path(cwd) / 'pubspec.yaml'
    gradle_file = Path(cwd) / 'android/gradle/wrapper/gradle-wrapper.properties'

    if not main_file.is_file():
        print('main.dart not found')
        return

    if not pubspec_file.is_file():
        print('pubspec.yaml not found')
        return

    if not gradle_file.is_file():
        print('gradle-wrapper.properties not found')
        return

    for line in fileinput.input(main_file, inplace = True):
        line = line.rstrip()
        if not re.match(r'^\s*//.*$', line):
            print(re.sub(r'(.*?) //.*$', r'\1', line))

    for line in fileinput.input(pubspec_file, inplace = True):
        line = line.rstrip()
        if not re.match(r'^\s*#.*$', line):
            print(line)

    # TODO: also fix the gradle version in /home/ale/AndroidStudioProjects/flutter_firebase/android/gradle/wrapper/gradle-wrapper.properties
    # distributionUrl=https\://services.gradle.org/distributions/gradle-6.3-all.zip
    # for line in fileinput.input(gradle_file, inplace = True):
    #     line = line.rstrip()
    #     print(re.sub(r'', r'gradle-6.3-all.zip', line))
    #         print(line)

if __name__ == "__main__":
    main()
