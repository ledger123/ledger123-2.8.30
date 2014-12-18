#!/bin/sh

# bp 2014/6/30 create missing fonts, user must be www-data

# change permissins of missfont.log
chmod ugoa+s ./missfont.log

# run creation program as www-data
sudo sh ./missfont.log

# delete the log file
rm ./missfont.log


