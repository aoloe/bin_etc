#!/bin/bash
exit

# scribus

## on linux

get the scribus trunk into the `scribus/` directory

    svn co svn://scribus.net/trunk/Scribus scribus



#/usr/local/cmake/bin/cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus14 -DLIBPODOFO_DIR=/usr/local/podofo/ -DWANT_CAIRO=1 -DWANT_DEBUG=1
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus15 -DLIBPODOFO_DIR=/usr/local/podofo/ -DWANT_DEBUG=1 -DWANT_NOOSG=1
mkdir build/
cd build/
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus15 -DWANT_DEBUG=1 -DWANT_NOOSG=1 ..
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/scribus15 -DWANT_DEBUG=1 -DWANT_NOOSG=1 -DWANT_PRIVATE_CAIRO=1 -DWANT_SCRIPTER2=1
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus-github -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus -DWANT_DEBUG=1 -DWANT_NOOSG=1 -DWANT_SCRIPTER2=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus-host -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus-indigo -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus_oif -DWANT_DEBUG=1 -DWANT_NOOSG=1 ..
svn co svn://scribus.net/branches/Version14x/Scribus scribus14
cmake -DCMAKE_INSTALL_PREFIX:PATH=/home/ale/bin/scribus14 -DWANT_DEBUG=1 -DWANT_GUI_LANG="en_GB;de;fr;it;en" ..
make
sudo rm -rf /usr/local/scribus15~
sudo mv /usr/local/scribus15 /usr/local/scribus15~
sudo make install


-DWANT_GUI_LANG="en_GB;de;fr;it;en" // to reduce the number of languages for the GUI


 grep -rl 'lib/lib' resources/translations/  | xargs sed -i 's/lib\/lib\//lib\//g'

### spcecial cases

mrb's cmake:

    $ cmake -DQT_PREFIX="/Users/craig/Qt/5.6/clang_64" \
        -DWANT_HUNSPELL=1 -DWANT_NOHEADERINSTALL=1 -DWANT_NOEXAMPLES=1 \
       -DWANT_GRAPHICSMAGICK=1 -DCMAKE_OSX_ARCHITECTURES="x86_64" -DBUILD_OSX_BUNDLE=1 \
       -DWANT_UNIVERSAL_BUNDLE=0 -DWANT_DEBUG=1 \
       -DWANT_SVNVERSION=1 \
       -DWANT_NOOSG=1 \
       -DWANT_GUI_LANG="en_GB;de;fr" \
       -DCMAKE_INSTALL_PREFIX:PATH=/Users/craig/Applications/Scribus.app/ ../trunk/Scribus/

- if you have a custom install of qt:

      export PATH='/usr/local/qt-4.4/bin':$PATH
  
  and / or `-DQT_PREFIX="/Users/craig/Qt/5.6/clang_64"`

# quassel

cmake -DWANT_MONO=ON -DUSE_QT5=ON -DCMAKE_INSTALL_PREFIX=~/bin/quassel ..

# lua love

./configure --prefix=/home/ale/bin/love
