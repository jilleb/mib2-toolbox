#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH
export IPL_CONFIG_DIR=/etc/eso/production

echo "Killing VNC Client Process"

pkill opengl-render-qnx

sleep 5

echo "Probably killed..."

exit 0