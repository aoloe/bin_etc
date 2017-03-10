#!/bin/bash

# a.l.e: temporary fix for installing ublock origin in chromium
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=852398
CHROMIUM_FLAGS='--enable-remote-extensions' /usr/bin/chromium
