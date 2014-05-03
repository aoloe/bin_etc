#!/bin/bash
NEWDATE=`date +%T --date '+1 hours'`;
date +%T -s "$NEWDATE";
hwclock -w
