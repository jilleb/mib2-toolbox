#!/bin/sh
# This script is meant to gal.json
# author: Jille
########################
#info
TOPIC=AndroidAuto
DESCRIPTION="This script will recover patched AA config files."

#Volumes/files
VOLUME=/fs/sda0
FILENAME=gal.json
ORIGINAL=/etc/eso/production/


. /eso/hmi/engdefs/scripts/mqb/util_info.sh

BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC

if [ ! -f "$BACKUPFOLDER/$FILENAME" ]; then
    echo "Backup not found. Cannot recover. Make sure you've made a backup"
    exit 0
fi

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /net/mmx/mnt/system

echo Copying gal.json from backup folder on SD-card.
cp $BACKUPFOLDER/$FILENAME $ORIGINAL/$FILENAME

# Make readonly again
mount -ur /mnt/app
mount -ur /mnt/system

echo Done. You are now back to the original configuration.

exit 0
