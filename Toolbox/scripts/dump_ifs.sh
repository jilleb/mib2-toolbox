#!/bin/sh

#info
TOPIC=IFS
DESCRIPTION="This script will dump the ifs-root."

#Volumes/files
ORIGINAL=/net/rcc/dev/fs0

echo $DESCRIPTION

. /eso/hmi/engdefs/scripts/mqb/util_info.sh
. /eso/hmi/engdefs/scripts/mqb/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

sleep .5

#Make dump folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER
mkdir -p $DUMPFOLDER
echo "Please wait while the file is dumped"
echo "It will appear like nothing is happening."
sleep 1

echo
echo "Dumping, this will take a while. Please be patient."
cat $ORIGINAL > $DUMPFOLDER/ifs_dump.bin

# Make readonly again
mount -ur $VOLUME

echo "Done. IFS-root dump can be found in the Dump folder on your SD-card"

exit 0
