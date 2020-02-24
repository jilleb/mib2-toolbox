#!/bin/sh

# inputs:
# 1: TOPIC, which is turned into a folder structure on the first available SD-card
# 2: path to backup from
TOPIC=$1
PATH=$2

#info
DESCRIPTION="This script will create backup folders for $TOPIC and backup files from $PATH"

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo "---------------------------"
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION
echo "---------------------------"
echo ""
sleep .5

#Is there any SD-card inserted?
if [ -d /net/mmx/fs/sda0 ]; then
    echo SDA0 found
    VOLUME=/net/mmx/fs/sda0
elif [ -d /net/mmx/fs/sdb0 ] ; then
    echo SDB0 found
    VOLUME=/net/mmx/fs/sdb0
else 
    echo No SD-cards found.
    exit 1
fi

sleep .5

echo Mounting SD-card.
mount -uw $VOLUME

sleep .5

#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC/

if [ -d "$BACKUPFOLDER" ] ; then
 echo "Backup already exists."
 echo "No backup will be made."
 exit 0
fi

echo Making backup folders on SD-card.
mkdir -p $BACKUPFOLDER

echo Copying file to backup folder on SD-card.
cp $PATH/*.* $BACKUPFOLDER


# Make readonly again
mount -ur $VOLUME

echo "Backup done."
echo "Backups are placed at $BACKUPFOLDER"

exit 0
