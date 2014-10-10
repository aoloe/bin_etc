#!/bin/bash
# TODO: implement the help
if [ $1 -gt 0 ]; then
    NEWDATE=`date +%T --date "+$1 minutes"`;
echo "plus"
else
echo "minus"
    NEWDATE=`date +%T --date "$1 minutes"`;
fi
date +%T -s "$NEWDATE";
