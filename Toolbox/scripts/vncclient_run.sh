#!/bin/sh
export PATH=/proc/boot:/bin:/usr/bin:/usr/sbin:/sbin:/mnt/app/media/gracenote/bin:/mnt/app/armle/bin:/mnt/app/armle/sbin:/mnt/app/armle/usr/bin:/mnt/app/armle/usr/sbin:$PATH
export IPL_CONFIG_DIR=/etc/eso/production

echo "Starting VNC Client on the unit untill reboot"
echo "Only works if the phone got IP 10.173.189.62. Otherwise refer to Github Repo"

cd /net/mmx/mnt/app/navigation
. /opengl-render-qnx

sleep 5

exit 0