#!/bin/sh

#info
TOPIC=Gracenote
DESCRIPTION="This script will dump Gracenote DB"

#Volumes/files
ORIGINAL=/net/mmx/mnt/gracenotedb

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make dump folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER
echo Dumping, please wait.
sleep 1

echo
echo Copying Gracenote DB to SD-card. This will take a while
cp -r $ORIGINAL $DUMPFOLDER/

# Make readonly again
mount -ur $VOLUME

echo "Done. Gracenote DB dump can be found in the Dump folder on your SD-card"

exit 0
