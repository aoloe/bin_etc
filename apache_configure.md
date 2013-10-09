# configure apache on debian

- put one config file per "local" site into /

/etc/apache2/sites-available/

/etc/apache2/sites-available/mamma

<VirtualHost *:80>
	ServerName ww.mamma.it
	DocumentRoot /home/ale/docs/htdocs/reclaimyourtools/htdocs/
	<Directory / >
		Options FollowSymLinks
		AllowOverride FileInfo Options
	</Directory>
</VirtualHost>

use a2ensite mamma to enable it
use a2dissite mamma to desable it

 just have to make sure that apache answers to *:80
