#!/bin/bash
# TODO: implement the help
NEWDATE=`date +%T --date "+$1 minutes"`;
date +%T -s "$NEWDATE";
