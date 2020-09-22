#!/bin/sh
#info
TOPIC=Splashscreen
DESCRIPTION="This script will recover the original splash.canim from Splashscreen folder on your SD to the unit."

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

#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC

echo Mounting persist folder.
mount -uw /mnt/persist/

echo Copying backup file from SD to MIB.
cp $BACKUPFOLDER/splash.canim /mnt/persist/var/splash.canim

# Make readonly again
mount -ur /mnt/persist/
mount -ur $VOLUME

echo Done. 
echo Restart the unit.

exit 0
