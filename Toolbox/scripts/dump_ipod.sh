#!/bin/sh

#info
TOPIC=CarPlay
DESCRIPTION="This script will dump ipod.cfg"

#Volumes/files
ORIGINAL=/net/mmx/mnt/system/etc/ipod.cfg

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
echo Dumping, please wait
sleep 1

echo Copying files
cp $ORIGINAL $DUMPFOLDER/ipod.cfg

# Make readonly again
mount -ur $VOLUME

echo "Done. ipod.cfg dump can be found in the Dump folder on your SD-card"

exit 0
