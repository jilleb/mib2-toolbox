#!/bin/sh

#info
TOPIC=AndroidAuto
DESCRIPTION="This script will dump Android Auto config file"

#Volumes/files
ORIGINAL=/etc/eso/production/gal.json

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
echo Copying Android Auto config file to SD-card.
cp  $ORIGINAL $DUMPFOLDER/

# Make readonly again
mount -ur $VOLUME

echo "Done. Android Auto config file dump can be found in the Dump folder on your SD-card"

exit 0
