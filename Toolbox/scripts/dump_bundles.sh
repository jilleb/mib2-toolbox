#!/bin/sh

#info
TOPIC=Bundles
DESCRIPTION="This script will dump all files in /eso/bundles/"
echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Mounting app folder
echo "Mounting app folder."
mount -uw /mnt/app

#Make backup folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER

mkdir -p $DUMPFOLDER
echo "Please wait while the files are dumped"
echo "It will appear like nothing is happening."
sleep 1
echo
echo "Dumping, this can take a moment. Please be patient."

cp /eso/bundles/*.jar $DUMPFOLDER/

# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME

echo "Done. Bundles dump can be found in the Dump folder on your SD-card"

exit 0
