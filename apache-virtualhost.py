#!/usr/bin/python3
# Create a standard virtualhost configuration that can be used
# in /etc/apache2/site-available

import os
import sys

from string import Template
from os.path import expanduser

if (len(sys.argv) != 2) :
    print(len(sys.argv))
    sys.exit("Usage: "+os.path.basename(sys.argv[0])+" ww.servername.ch");
    

server = sys.argv[1]
print("Creating a config file for "+server)

documentRoot = expanduser("~/httpdocs/"+server+"/httpdocs")
logPath = expanduser("~/httpdocs/logs/"+server)

template = Template(\
"""<VirtualHost *:80>
    ServerAdmin ale@graphicslab.com
    ServerName $server
    ServerAlias $server

    DocumentRoot $documentRoot/

    <Directory $documentRoot/ >
        Options Indexes FollowSymLinks
        AllowOverride AuthConfig FileInfo
        Require all granted
    </Directory>

    ErrorLog $logPath/error.log
    CustomLog $logPath/access.log combined
</VirtualHost>""")

virtualHost = template.substitute(server=server, documentRoot=documentRoot, logPath=logPath)

file = open(server+".conf", "w")
file.write(virtualHost)
file.close()

print("File "+server+" has been written")
os.makedirs(documentRoot)
os.makedirs(logPath)

template = Template("""
    $ mkdir $server
    $ cd /etc/apache2/sites-available
    $ sudo ln -s $pwd/$server.conf .
    $ sudo a2ensite $server.conf
    $ sudo service apache2 reload
""")

print(template.safe_substitute(pwd=os.getcwd(), server=server))
