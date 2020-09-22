#!/bin/sh
#info
TOPIC=AndroidAuto
DESCRIPTION="This script will recover patched AA config files."

#Volumes/files
VOLUME=/fs/sda0
FILENAME=gal.json
ORIGINAL=/etc/eso/production/

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION
echo "---------------------------"
sleep .5

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /mnt/system

#Is there any SD-card inserted?
if [ -d /net/mmx/fs/sda0 ]; then
    echo SDA0 found
    VOLUME=/net/mmx/fs/sda0
elif [ -d /net/mmx/fs/sdb0 ] ; then
    echo SDB0 found
    VOLUME=/net/mmx/fs/sdb0
else 
    echo No SD-cards found.
    exit 0
fi

sleep .5

echo Mounting SD-card.
mount -uw $VOLUME

sleep .5

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
