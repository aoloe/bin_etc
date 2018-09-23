#!/usr/bin/python2
# usage:
# scribus -g -py scribus-to-pdf.py -- filename.sla
# Creates a pdf at the original size and one imposed on A4.
# 
# or
#
# python scribus-to-pdf.py [filename.sla]
# Call this script through scribus for each file in the directory or for the given Scribus file
#
# TODO:
# - if the python scripts has a .sla as an argument, place the PDFs in that path.
# - eventually, detect the current page size for the layout and the target file name of the pdfnup command (a5/a6)

import os
import sys

try:
    import scribus
except ImportError:
    # if the script does not run inside of scribus, launch scribus with this script as paremeter
    
    filename = []

    if (len(sys.argv) == 2) :
        print "launching the script for " + sys.argv[1]
        filename.append(sys.argv[1])
    else:
        print "launching the script for each .sla in the directory."
        for file in os.listdir('.'):
            filenameSplit = os.path.splitext(file)
            if filenameSplit[-1] == '.sla' and filenameSplit[0].find('_autosave_') == -1:
                filename.append(file)

    for file in filename :
        print(file)
        os.system('scribus -g -py ' + sys.argv[0] + ' -- ' + file)

    sys.exit(1)

if scribus.haveDoc():
    filename = os.path.splitext(scribus.getDocName())[0]
    pdf = scribus.PDFfile()
    pdf.file = filename + ".pdf"
    pdf.save()

    pdf = scribus.PDFfile()
    pdf.file = filename + "-reordered.pdf"
    if (scribus.pageCount() == 1) :
        pdf.pages = [1,1,1,1]
    elif (scribus.pageCount() == 2) :
        pdf.pages = [1,1,1,1,2,2,2,2]
    elif (scribus.pageCount() == 4) :
        pdf.pages = [4,1,4,1,2,3,2,3]
    elif (scribus.pageCount() == 8) :
        pdf.pages = [8,1,6,3,2,7,4,5]
    elif (scribus.pageCount() == 12) :
        pdf.pages = [12, 1, 2, 11, 10, 3, 4, 9, 8, 5, 6, 7]
    elif (scribus.pageCount() == 16) :
        # pdf.pages = [16, 1, 2, 15, 14, 3, 4, 13, 12, 5, 6, 11, 10, 7, 8, 9] # <- probably wrong
        pdf.pages = [16, 1, 14 , 3, 2, 15, 4, 13, 12, 5, 10, 7, 6, 11, 8, 9] # <- first join top/down , then staple 1/2
    else:
        print('{} are not yet supported'.format(scribus.pageCount()))
    pdf.save()

    os.system("pdfnup --nup 2x2 --frame false --no-landscape " + filename + "-reordered.pdf --outfile " + filename.replace("a6", "a4") + ".pdf")
    os.remove(pdf.file)
else:
    print("No file open");
