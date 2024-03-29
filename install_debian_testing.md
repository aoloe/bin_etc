as of jessie

(for stretch, it seems to be possible to directly install from the testing iso)

- install from netinst for stable
- edit /etc/apt/list.sources to get testing
- apt-get update and dist-upgrade
- install
  - aptitude
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
  - (xinit: should come in with xorg)
  - git
    - copy over the ~/.ssh/ directory
  - (wmii: see dwm below)
    - set ´~/.xinitrc` to `exec wmii`
  - dwm, st, dmenu (from git)
    - see the notes below for dwm
    - see the notes below for st
    - set the prefi in config.mk for dmenu for installing it in the home
  - ninja-build
  - for the digiteis laptop: firmware-brcm80211
  - (wicd: use the interfaces file directly)
  - openssh-server
  - firefox developer edition
  - apache
  - php7
  - mysql-client and mysql-server
  - chromium + download firex development from the web (needs libgtk3 and libdbus-glib-1.2)
  - hexchat (quassel)
    needs (can i do them as plugins?):
    - textarea for typing text
    - formatting + tooltip on date / nick column
    - auto add # in front of the channel name
  - claws-mail
  - ncftp
  - zeal (offline documentation)
- edit .vimrc to use bin-etc
- (edit the xterm settings according to bin-etc)
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
- for claws-mail, make sure that 

      mainwin_maximised=1
      mainwin_fullscreen=0
      next_on_delete=1

## dwm

to get dwm and compile it:

- git (and configure it)
- build-essential
- libx11-dev
- libxft-dev


set `.xinitrc` to 

    exec dwm


dwm is a non-reparenting window manager and java application tend to misbehave (menus, window size). add to  in `.xinitrc` the the following environment variable:

    export _JAVA_AWT_WM_NONREPARENTING=1

and start with `startx`


## suckless configs and patches

### dwm

applied:

- windows key: instead of alt

further changes:

- disable mod-0 (with many windows it crashes X11)

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

some patches sources:

- http://brittonkerin.com/sdwm
- http://github.com/jceb/dwm-patches
- http://github.com/jceb/dwm-clean-patches
- 

### st

- get it from git
- in `config.h` switch `defaultfg` and `defaultbg`
- set PREFIX in config.mk and then ln -s in /usr/local/bin
- apply the patches:
  - hidecursor
  - visualbell
  - solarize
    - https://github.com/altercation/vim-colors-solarized
    - (does not correctly apply... changes must be copied in config.h manually)
  - (scrollback does not apply and one can always pipe to less...)
- https://wiki.archlinux.org/index.php/St

## further packages

- `pm-tools for power management
- `tlp` for advanced power management (not yet installed)

## opengl and qml

<https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/1876219> says:

```
Adding this line to ~/.profile helps for me as workaround.
"export MESA_LOADER_DRIVER_OVERRIDE=i965"
```

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

## bluetooth

- install the packages according to <https://wiki.debian.org/BluetoothUser/a2dp>
- install bluez-tools
- `bluetoothctl scan` to get he list of available devices
- `pair 0<tab>`
- `connect 0<tab>`
- `pavucontrol` lets control the volume for each device (alsamixer does nothing)
- <https://wiki.archlinux.org/index.php/Dell_XPS_13_(2016)#Wireless_headset:_strange_bluetooth_behavior> says that a proprietary driver might be needed... (but it should be for the broadcom wifi card)
- `pacmd list-sinks` lists the available output devices
- `pacmd set-default-sink 3` activates a specific output device. (you might have to restart the program)
