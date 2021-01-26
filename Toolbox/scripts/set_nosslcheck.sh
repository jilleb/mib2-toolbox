#!/bin/sh

mount -uw /mnt/app/ 
touch /eso/hmi/no-ssl-cert-check
touch /eso/hmi/no-ssl-cert-check
sync; sync; sync
echo "Done, please reboot"
