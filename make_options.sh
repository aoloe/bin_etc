#!/bin/bash
exit
cd ~/src/
rm -rf Scribus
svn co svn://scribus.net/trunk/Scribus scribus
cd Scribus
export PATH='/usr/local/qt-4.4/bin':$PATH
#/usr/local/cmake/bin/cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus14 -DLIBPODOFO_DIR=/usr/local/podofo/ -DWANT_CAIRO=1 -DWANT_DEBUG=1
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus15 -DLIBPODOFO_DIR=/usr/local/podofo/ -DWANT_DEBUG=1 -DWANT_NOOSG=1
mkdir build/
cd build/
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus15 -DWANT_DEBUG=1 -DWANT_NOOSG=1 ..
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus15 -DWANT_DEBUG=1 -DWANT_NOOSG=1 -DWANT_PRIVATE_CAIRO=1 -DWANT_SCRIPTER2=1
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/docs/bin/scribus_scripter -DWANT_DEBUG=1 -DWANT_NOOSG=1 -DWANT_SCRIPTER2=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/docs/bin/scribus -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/docs/bin/scribus_git -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/docs/bin/scribus_oif -DWANT_DEBUG=1 -DWANT_NOOSG=1 ..
svn co svn://scribus.net/branches/Version14x/Scribus scribus14
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/docs/bin/scribus14 -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
make
sudo rm -rf /usr/local/scribus15~
sudo mv /usr/local/scribus15 /usr/local/scribus15~
sudo make install


-DWANT_GUI_LANG="en_GB;de;fr;it;en" // to reduce the number of languages for the GUI


 grep -rl 'lib/lib' resources/translations/  | xargs sed -i 's/lib\/lib\//lib\//g'


cmake -DWANT_MONO=ON -DUSE_QT5=ON -DCMAKE_INSTALL_PREFIX=~/docs/bin/quassel ..
