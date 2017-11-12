#!/bin/bash
userName=juancho
#(1) Allow Apache access to the folders and the files.
sudo chgrp -R www-data /var/www/html
sudo find /var/www/html -type d -exec chmod g+rx {} +
sudo find /var/www/html -type f -exec chmod g+r {} +
#(2) Give your owner read/write privileges to the folders and the files, 
#and permit folder access to traverse the directory structure.
sudo chown -R ${userName} /var/www/html/
sudo find /var/www/html -type d -exec chmod u+rwx {} +
sudo find /var/www/html -type f -exec chmod u+rw {} +
#(3) (Optional) Make sure every new file after this is created with www-data as the 'access' user.
sudo find /var/www/html -type d -exec chmod g+s {} +
#(4) (Optional) Final security cleanup, if you don't want other users to be able to see the data
sudo chmod -R o-rwx /var/www/html/