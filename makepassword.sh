# pwgen -y 40 1
cat /dev/urandom| tr -dc 'a-zA-Z0-9-_!#$%^&*()_+{}|:<>?='|fold -w 12| head -n 4| grep -i '[!@#$%^&*()_+{}|:<>?=]'
