#!/bin/bash
jmtpfs -o allow_other /mnt/nexus7
exit;

or:
- install `mtp-tools` and `jmtpfs`
- `mkdir /mnt/nexus7` and `chmod a+w /mnt/nexus7`
- add to `/etc/fstab`
      jmtpfs /mnt/nexus7    fuse    user,noauto,allow_other  0       0
- add the user to the `fuse` group (`addgroup ale fuse`)
- reload the `fuse` group (`newgrp fuse` or login again)
- now `mount /mnt/nexus7` should be working for the user `ale`
