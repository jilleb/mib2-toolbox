#!/bin/sh

#info
TOPIC=Mapstyles
DESCRIPTION="This script will dump Mapstyles"

#Volumes/files
ORIGINAL=/net/mmx/mnt/app/navigation/resources/app/

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
echo Copying Mapstyles to SD-card. This could take a while
cp -R $ORIGINAL $DUMPFOLDER/

# Make readonly again
mount -ur $VOLUME

echo "Done. Mapstyles dump can be found in the Dump folder on your SD-card"

exit 0
