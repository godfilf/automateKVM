#! /bin/bash -x

usid=$(id -u `whoami`)
grid=$(id -g `whoami`)

#echo "sudo -s chown $usid:$grid $1"

sudo -s chown $usid:$grid $1

exit 0
