#!/bin/bash
dest=/var/www/html/cgi-bin
mkdir -p ${dest}
cp -a *.py ${dest}
cp -R pages css data html js utils ${dest}
sh bash/./apachecredentials.sh
