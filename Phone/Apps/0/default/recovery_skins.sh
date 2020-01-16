#!/bin/sh

# This script is meant to recover all skin mcf files
# author: Jille
########################

#info
TOPIC=Skinfiles
DESCRIPTION="This script will recover the backupped skinfiles and ambienceColorMaps"

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


#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC
MIBFOLDER=/eso/hmi/splashscreen/

# Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
echo Copying all skin files from backup folder on SD-card.
echo Please be patient.

RESOURCESFOLDER=/eso/hmi/lsd/Resources/
cp $BACKUPFOLDER/skin0/images.mcf $RESOURCESFOLDER/skin0/images.mcf
cp $BACKUPFOLDER/skin1/images.mcf $RESOURCESFOLDER/skin1/images.mcf
cp $BACKUPFOLDER/skin2/images.mcf $RESOURCESFOLDER/skin2/images.mcf
cp $BACKUPFOLDER/skin3/images.mcf $RESOURCESFOLDER/skin3/images.mcf
cp $BACKUPFOLDER/skin4/images.mcf $RESOURCESFOLDER/skin4/images.mcf
cp $BACKUPFOLDER/skin5/images.mcf $RESOURCESFOLDER/skin5/images.mcf

cp $BACKUPFOLDER/skin0/ambienceColorMap.res $RESOURCESFOLDER/skin0/ambienceColorMap.res
cp $BACKUPFOLDER/skin1/ambienceColorMap.res $RESOURCESFOLDER/skin1/ambienceColorMap.res
cp $BACKUPFOLDER/skin2/ambienceColorMap.res $RESOURCESFOLDER/skin2/ambienceColorMap.res
cp $BACKUPFOLDER/skin3/ambienceColorMap.res $RESOURCESFOLDER/skin3/ambienceColorMap.res
cp $BACKUPFOLDER/skin4/ambienceColorMap.res $RESOURCESFOLDER/skin4/ambienceColorMap.res
cp $BACKUPFOLDER/skin5/ambienceColorMap.res $RESOURCESFOLDER/skin5/ambienceColorMap.res


$ Make readonly again
mount -ur /mnt/app

echo Done. You are now back to the original files.

exit 0
