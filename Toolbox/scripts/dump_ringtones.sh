#!/bin/sh

#info
TOPIC=Ringtones
DESCRIPTION="This script will dump telephone ringtones"

#Volumes/files
ORIGINAL=/net/mmx/mnt/app/hb/ringtones/*.*

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
echo Copying telephone ringtones to SD-card.
cp  $ORIGINAL $DUMPFOLDER/

# Make readonly again
mount -ur $VOLUME

echo "Done. Telephone ringtones dump can be found in the Dump folder on your SD-card"

exit 0
