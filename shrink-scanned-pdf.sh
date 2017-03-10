#!/bin/sh

imageResolution=300

gs  -q -dNOPAUSE -dBATCH -dSAFER \
    -sDEVICE=pdfwrite \
    -dCompatibilityLevel=1.3 \
    -dPDFSETTINGS=/screen \
    -dEmbedAllFonts=true \
    -dSubsetFonts=true \
    -dColorImageDownsampleType=/Bicubic \
    -dColorImageResolution=$imageResolution \
    -dGrayImageDownsampleType=/Bicubic \
    -dGrayImageResolution=$imageResolution \
    -dMonoImageDownsampleType=/Bicubic \
    -dMonoImageResolution=$imageResolution \
    -sOutputFile=out.pdf \
     $1
