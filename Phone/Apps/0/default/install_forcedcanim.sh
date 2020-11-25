#!/bin/sh

#info
export TOPIC=Splashscreen
export DESCRIPTION="This script will copy custom splash.canim from Splashscreen folder on your SD to the unit."
export MIBPATH=/mnt/persist/var/splash.canim
export SDPATH=/$TOPIC/splash.canim
export TYPE="file"

echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app


#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC

# Make app volume writable
echo Mounting persist folder.
mount -uw /mnt/persist/
#include script to make backup
. /eso/bin/PhoneCustomer/default/util_backup.sh

# include script tocopy file(s)
# remount everything as read-only again
. /eso/bin/PhoneCustomer/default/util_copy.sh


echo Copying modified files from SD splashscreen folder to MIB.
cp $VOLUME/Custom/$TOPIC/splash.canim /mnt/persist/var/splash.canim

# Make readonly again
mount -ur /mnt/persist/
mount -ur $VOLUME

echo Done. 
echo Restart the unit.

exit 0
