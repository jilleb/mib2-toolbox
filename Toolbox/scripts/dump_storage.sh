#!/bin/sh

#info
TOPIC=Storage
DESCRIPTION="This script will dump storage1.raw and storage2.raw"

#Volumes/files
ORIGINAL=/net/rcc/mnt/efs-persist/*.raw

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make backup folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER
echo "Please wait while the file is dumped"
echo "It will appear like nothing is happening."
sleep 1

echo
echo "Dumping, this will take a while. Please be patient."
cp  $ORIGINAL $DUMPFOLDER/

# Make readonly again
mount -ur $VOLUME

echo "Done. storage1.raw and storage2.raw dump can be found in the Dump folder on your SD-card"

exit 0
