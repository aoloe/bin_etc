#!/bin/bash

# remove all vim's .*.swp files

find . -type f -name ".*.swp" -exec rm -f {} \;
