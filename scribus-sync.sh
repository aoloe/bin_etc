#!/bin/bash
is_ssh_add=$(ssh-add -l)

# compare the result
if [[ "$is_ssh_add" == "The agent has no identities" ]]; then
	echo "please run ssh-add first"
	exit
fi

echo "scribus 1.7 update"
cd ~/src/scribus-for-sync/
~/src/scribus-svn-git/update_from_svn.sh

echo "scribus 1.6 update"
cd ~/src/scribus-16-for-sync/
~/src/scribus-16-svn-to-gitlab/update.sh
