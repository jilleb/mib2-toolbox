#!/bin/sh

# This script is meant to recover all skin mcf files
# author: Jille
########################

#info
TOPIC=Skinfiles
DESCRIPTION="This script will recover the backupped skinfiles and ambienceColorMaps"


. /eso/bin/PhoneCustomer/default/util_info.sh

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

. /eso/bin/PhoneCustomer/default/util_mountsd.sh

#Make backup folder
BACKUPFOLDER=$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC

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
cp $BACKUPFOLDER/skin6/images.mcf $RESOURCESFOLDER/skin6/images.mcf

cp $BACKUPFOLDER/skin0/ambienceColorMap.res $RESOURCESFOLDER/skin0/ambienceColorMap.res
cp $BACKUPFOLDER/skin1/ambienceColorMap.res $RESOURCESFOLDER/skin1/ambienceColorMap.res
cp $BACKUPFOLDER/skin2/ambienceColorMap.res $RESOURCESFOLDER/skin2/ambienceColorMap.res
cp $BACKUPFOLDER/skin3/ambienceColorMap.res $RESOURCESFOLDER/skin3/ambienceColorMap.res
cp $BACKUPFOLDER/skin4/ambienceColorMap.res $RESOURCESFOLDER/skin4/ambienceColorMap.res
cp $BACKUPFOLDER/skin5/ambienceColorMap.res $RESOURCESFOLDER/skin5/ambienceColorMap.res
cp $BACKUPFOLDER/skin6/ambienceColorMap.res $RESOURCESFOLDER/skin6/ambienceColorMap.res

$ Make readonly again
mount -ur /mnt/app

echo Done. You are now back to the original files.

exit 0
