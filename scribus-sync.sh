#!/bin/sh

echo "scribus 1.7 update"
cd ~/src/scribus-for-sync/
~/src/scribus-svn-git/update_from_svn.sh

echo "scribus 1.6 update"
cd ~/src/scribus-16-for-sync/
~/src/scribus-16-svn-to-gitlab/update.sh
