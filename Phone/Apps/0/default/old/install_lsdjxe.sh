#!/bin/sh

# This script is meant to copy all  files from the source to MIB and backup the original ones
# author: Jille
########################

#info
TOPIC=LSD
DESCRIPTION="This script will copy custom  lsd.jxe from SD to your unit."

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

MIBFOLDER=/net/mmx/ifs/
SOURCEFOLDER=$VOLUME/Advanced/LSD/

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /net/mmx/ifs/
mount -uw /net/mmx/mnt/system

echo Copying modified file from SD  to MIB.
cp $SOURCEFOLDER/lsd.jxe /$MIBFOLDER/lsd.jxe

# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME
mount -ur /net/mmx/ifs/
mount -ur /net/mmx/mnt/system

echo Done. 

exit 0
