#!/bin/sh

mount -uw /mnt/app/ 
rm /eso/hmi/no-ssl-cert-check
rm /eso/hmi/no-ssl-cert-check
sync; sync; sync
echo "Done, please reboot"
