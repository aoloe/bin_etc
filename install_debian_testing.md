as of jessie

(for stretch, it seems to be possible to directly install from the testing iso)

- install from netinst for stable
- edit /etc/apt/list.sources to get testing
- apt-get update and dist-upgrade
- install
  - sudo
  - vim (and remove vim-tiny)
- configure:
  - update-alternatives --config editor
  - visudo
- create `/mnt/usb_a` and add it in `/etc/fstab`
  `/dev/sdb1       /mnt/usb_a    vfat    defaults,user,rw,noauto  0       0`
- install:
  - xorg

          sudo apt-get install xorg xserver-xorg-core \
          xserver-xorg-input-all xserver-xorg-video-fbdev \
          xserver-xorg-video-(yourcard, can be intel, nouveau, or ati)
    <http://unix.stackexchange.com/questions/128860/minimal-x-org-xserver-installation-on-debian-wheezy>  
    if <startx> still does not work, try to install `xserver-xorg-video-all`
  - xinit
  - wmii
    - set ´~/.xinitrc` to `exec wmii`
  - xorg
  - aptitude
  - for the digiteis laptop: firmware-brcm80211
  - wicd
  - openssh-server
  - git
  - apache
  - php5
  - mysql-client and mysql-server
  - chromium + download firex development from the web (needs libgtk3 and libdbus-glib-1.2)
  - wmii
  - hexchat (quassel)
    needs (can i do them as plugins?):
    - textarea for typing text
    - formatting + tooltip on date / nick column
    - auto add # in front of the channel name
  - claws-mail
  - ncftp
- copy over the ~/.ssh/ directory
- edit .vimrc to use bin-etc
- edit the xterm settings according to bin-etc
- configure the ssd using by editing the fstab and reducing the swap:
  - add to /etc/sysctl.conf
        # Sharply reduce swap inclination
        m.swappiness=1
         Improve cache management
         vm.vfs_cache_pressure=50
    https://sites.google.com/site/easylinuxtipsproject/ssd
    (eventually it seems to be good to have about 10GB of unallocated space)
- configure wmii in /etc/X11/wmii/wmiirc
  - tweak the status bar
        echo -n label $(acpi -b |tr -d ','|awk '{if ($3=="Discharging") {print "-[ ]· " $4 " (" $5 ")"} else {print "-[|= " $4}}') '|' $(uptime | sed 's/.*://; s/, / /g' | awk '{print $1}') '|' $(date "+%a %d %h %H:%M")
- copy over the ncftp bookmarks

## dwm

to get dwm and compile it:

- git (and configure it)
- build-essential
- libx11-dev
- libxft-dev


set `.xinitrc` to 

    exec dwm

and start with `startx`

## suckless configs and patches

### dwm

applied:

- windows key: instead of alt

to be applied:

- statuscolor
- hide vacant tags
- gapless grid layout
- maximize
- "movestack" or "push"
- nametag
- resizecorners
- save floats
- stackmfact
- switchcol
- systray

maybe:

- cfacts
- "fancybar" or rather "pango"
- float border color
- focus adjacent tag (or next prev tag / shiftview)
- gap
- "nmaster" patch (patch it to only have stacked layout from wmii?) or "tab" (but not for monocle)

### st

- get it from git
- in `config.h` switch `defaultfg` and `defaultbg`
- apply the patches:
  - hidecursor
  - visualbell
  - (scrollback does not apply and one can always pipe to less...)
- https://wiki.archlinux.org/index.php/St

## further packages

- `pm-tools for power management
- `tlp` for advanced power management (not yet installed)

## virtualbox

- add `xserver-xorg-legacy` to get x11 to work correctly.
- add the guest addtions: (no solution found for debian testing, yet)
  - <strike>add `contrib` to `sources.list` and install `virtualbox-guest-x11`.</strike>
  - or
    - <https://forums.virtualbox.org/viewtopic.php?t=15679>
    - `apt-get install dkms build-essential linux-headers-amd64`
    - `mount /dev/sr0 /media/cdrom`
    - `/media/cdrom` and `sh ./VBoxLinuxAdditions.run`
    - reboot
  - add `contrib` to `sources.list` and install `virtualbox-guest-x11`.

## hidpi

normally, it has 96 dpi, scaling at 125% gives 120.  so create `~/.Xresources` as

~~~
Xft.dpi: 120
Xft.autohint: 0
Xft.lcdfilter:  lcddefault
Xft.hintstyle:  hintfull
Xft.hinting: 1
Xft.antialias: 1
Xft.rgba: rgb
~~~

and load it at the beginning of `~/.xinitrc`

~~~
xrdb -merge ~/.Xresources
~~~

install `lxappearance` and choose `DejaVu Sans ExtraLight 10` as the default font.

## tools

- `pastebinit` for uploading to <http://paste.debian.net> from the terminal
