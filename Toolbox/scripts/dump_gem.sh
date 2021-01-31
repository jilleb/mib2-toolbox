#!/bin/sh

#info
TOPIC=GEM
DESCRIPTION="This script will dump GEM.jar"

#Volumes/files
ORIGINAL=/eso/hmi/lsd/jars/GEM.jar

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
echo Dumping, please wait. This can take a while.
sleep 1

echo Copying files
cp $ORIGINAL $DUMPFOLDER

# Make readonly again
mount -ur $VOLUME

echo "Done. GEM dump can be found in the Dump folder on your SD-card"

exit 0
