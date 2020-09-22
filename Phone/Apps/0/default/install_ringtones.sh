#!/bin/sh
TOPIC=Ringtones

#info
DESCRIPTION="This script will install Ringtones"
echo $DESCRIPTION
. /eso/bin/PhoneCustomer/default/util_info.sh
. /eso/bin/PhoneCustomer/default/util_mountsd.sh

#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

echo Making backup folders on SD-card.
mkdir -p $BACKUPFOLDER

echo Copying file to backup folder on SD-card.
cp /net/mmx/mnt/app/hb/ringtones/*.* $BACKUPFOLDER

echo Copying modified files from SD folder to MIB.
cp /$VOLUME/Custom/$TOPIC/*.* /net/mmx/mnt/app/hb/ringtones/
# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME

echo Done. 
echo "Please restart the unit to apply the new audio"
echo "Backups are placed at $BACKUPFOLDER"

exit 0
