#!/bin/sh

# This script is meant to copy all CANIM files from the source to MIB and backup the original ones
# author: Jille
########################

#info
TOPIC=Splashscreen
DESCRIPTION="This script will copy custom canim files from Splashscreen folder on your SD to the unit."

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
MIBFOLDER=/eso/hmi/splashscreen/
SOURCEFOLDER=$VOLUME/Splashscreen

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

echo Making backup folders on SD-card.
mkdir -p $BACKUPFOLDER

echo Copying files to backup folder on SD-card.
cp /$MIBFOLDER/*.* $BACKUPFOLDER

echo Copying modified files from SD splashscreen folder to MIB.
cp $SOURCEFOLDER/*.canim /$MIBFOLDER

# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME

echo Done. 
echo "Please set the startup graphic (module 5F, long coding byte 18) to a different value."
echo Restart the unit, and go back to the value of your choice.
echo If something is not working, please run the backup recovery-script.
echo Backup is saved to $BACKUPFOLDER

exit 0
