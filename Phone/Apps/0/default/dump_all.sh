#!/bin/sh

# This script is meant to dump all skin and android auto files
# author: Jille
########################

#info
DESCRIPTION="This script will dump skins, startup screens and android auto configuration"

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
DUMPPATH=$VOLUME/Dump/$VERSION/$FAZIT/

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

echo Making backup folders on SD-card.
mkdir -p $DUMPPATH

echo Dumping, please wait. This can take a while.

mount -uw /net/mmx/fs/sda0

mkdir -p $DUMPPATH/Skinfiles
echo Dumping skin files
cp -R /eso/hmi/lsd/Resources $DUMPPATH/Skinfiles/

echo Dumping startup screen files
mkdir -p $DUMPPATH/Splashscreen
cp /eso/hmi/splashscreen/*.* $DUMPPATH/Splashscreen/

echo Dumping Android Auto config filefiles
mkdir -p $DUMPPATH/AndroidAuto
cp /etc/eso/production/gal.json $DUMPPATH/AndroidAuto/

echo Dumping Ringtones
mkdir -p $DUMPPATH/Ringtones
cp /net/rcc/mnt/efs-system/opt/audio/tones/*.* $DUMPPATH/Ringtones/


# Make readonly again
mount -ur $VOLUME

echo Done. Now start tweaking the dumped stuff!

exit 0
