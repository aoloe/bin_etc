as of jessie

- install from netinst for stable
- edit /etc/apt/list.sources to get testing
- apt-get update and dist-upgrade
- install
  - sudo
  - vim (and remove vim-tiny)
- configure:
  - update-alternatives --config editor
  - visudo
- install:
  - xorg

          sudo apt-get install xserver-xorg-core \
          xserver-xorg-input-all xserver-xorg-video-fbdev \
          xserver-xorg-video-(yourcard, can be intel, nouveau, or ati)
    <http://unix.stackexchange.com/questions/128860/minimal-x-org-xserver-installation-on-debian-wheezy>  
    if <startx> still does not work, try to install `xserver-xorg-video-all`
  - xinit
  - wmii
  - xorg
  - aptitude
  - for the laptop: firmware-brcm80211
  - wicd
  - openssh-server
  - git
  - apache
  - php5
  - mysql-client and mysql-server
  - chromium
  - wmii
  - quassel
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

## virtualbox

- add the guest addtions:
  - <https://forums.virtualbox.org/viewtopic.php?t=15679>
  - `apt-get install dkms build-essential linux-headers-amd64`
  - `mount /dev/sr0 /media/cdrom`
  - `/media/cdrom` and `sh ./VBoxLinuxAdditions.run`
  - reboot

## tools

- `pastebinit` for uploading to <http://paste.debian.net> from the terminal
