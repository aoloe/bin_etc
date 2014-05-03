as of jessie

- install from netinst for stable
- edit /etc/apt/list.sources to get jessie
- apt-get update and dist-upgrade
- install
  - sudo
  - vim (and remove vim-timy)
  - wmii
  - xorg
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
        echo -n label $(acpi -b |tr -d ','|awk '{if ($3=="Discharging") {print "-[ ]· " $4 " (" $5 ")"} else {print "-(= " $4}}') '|' $(uptime | sed 's/.*://; s/, / /g' | awk '{print $1}') '|' $(date "+%a %d %h %H:%M")
- copy over the ncftp bookmarks
