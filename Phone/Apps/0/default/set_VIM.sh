#!/bin/sh   


#info
export TOPIC=Peristence
export DESCRIPTION="This script will patch Video in Motion."
export LD_LIBRARY_PATH=/mnt/app/root/lib-target:/eso/lib:/mnt/app/usr/lib:/mnt/app/armle/lib:/mnt/app/armle/lib/dll:/mnt/app/armle/usr/lib 
export IPL_CONFIG_DIR=/etc/eso/production 


echo $DESCRIPTION

. /eso/bin/PhoneCustomer/default/util_info.sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh

if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

export BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/
mkdir -p $BACKUPFOLDER

echo "Making backup of Storage1.raw"
cp /net/rcc/mnt/efs-persist/storage1.raw $BACKUPFOLDER
echo "Making backup of Storage2.raw"
cp /net/rcc/mnt/efs-persist/storage2.raw $BACKUPFOLDER

echo "Setting VIM to 200km/h"

on -f mmx /net/mmx/eso/bin/apps/pc b:0:3221422082 c7000602ff0000000014ff00ff00ff000000ff02ff02000000073031ac3f
		  
sync
sync
sync
echo "Patching done, please reboot for activation!"
echo "Don't be an ass: don't watch movies while driving."
sleep 1

echo "Resetting unit now"
sleep 2
mount -uw /mnt/system
touch /etc/ooc.allow.reset
echo hmi-sys-reset > /dev/ooc/reset
sleep 2
rm /etc/ooc.allow.reset
echo "Reboot request sent"

