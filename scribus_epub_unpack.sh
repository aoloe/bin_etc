#!/bin/bash
# currently just a command line that deletes the current directory and unpacks the
# new epub file at the same place... to be improved...

cd .. && rm -rf epub && mkdir epub && cp text.epub epub/ && cd epub && unzip text.epub
