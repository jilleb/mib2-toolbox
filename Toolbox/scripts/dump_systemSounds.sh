#!/bin/sh

#info
TOPIC=Systemsounds
DESCRIPTION="This script will dump system sounds"

#Volumes/files
ORIGINAL=/net/rcc/mnt/efs-system/opt/audio/tones/*.*

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make dump folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/Sounds/$TOPIC

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER
echo Dumping, please wait.
sleep 1

echo
echo Copying system sounds to SD-card.
cp  $ORIGINAL $DUMPFOLDER/

# Make readonly again
mount -ur $VOLUME

echo "Done. System sounds dump can be found in the Dump folder on your SD-card"

exit 0
