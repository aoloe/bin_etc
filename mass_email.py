#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import csv
from subprocess import call

# 0 Theme
# 1 ConferenceId
# 2 Titre
# 3 Introduction
# 4 Lang
# 5 Nom du conférencier
# 6 Email
# 7 Url
# 8 Notes
# 9 Biographie
# 10 Durée des conférences
# 11 Niveau des conférences
# 12 Description
# 13 Public cible

def strtr(strng, replace):
    if replace and strng:
        s, r = replace.popitem()
        return r.join(strtr(subs, dict(replace)) for subs in strng.split(s))
    return strng

def main():
    templatefilepath = "rmll.txt"
    with open (templatefilepath, "r") as templatefile:
        template = templatefile.read()#.replace('\n', '')
        print template
    csvfilepath = "rmll.csv"
    with open(csvfilepath, 'rb') as csvfile:
        csvreader = csv.reader(csvfile, delimiter=',', quotechar='"')
        next(csvreader, None)  # skip the headers
        for row in csvreader:
                message = template
                message = message.replace(":name", row[5])
                message = message.replace(":title", row[2])
                message = message.replace(":duration", row[10])
                message = message.replace(":language", row[4])
                message = message.replace(":level", row[11])
                message = message.replace('\n', '%%0D%%0A')
                #print row[6]
                arguments = 'mailto:' + row[6] +'?subject=RMLL 2014: ' + row[2] + '&body=' + message + '&cc=philippe giffard <pgiffard@hotmail.com>&from=ale rimoldi <ale@graphicslab.org>'
                #print arguments
                call(['claws-mail', '--compose', arguments])
                variable = raw_input('input something!: ')

if __name__ == "__main__":
    main()
