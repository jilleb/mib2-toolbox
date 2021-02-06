#!/bin/sh

#info
TOPIC=Shadowfile
DESCRIPTION="This script will dump the shadow file."

#Volumes/files
FILENAME=shadow
ORIGINAL=/net/mmx/mnt/system/etc/

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

echo Copying shadow file to SD-card.
cp /$ORIGINAL/$FILENAME $DUMPFOLDER/shadow.txt

#show contents
echo Listing file:
sleep .5

cat $DUMPFOLDER/shadow.txt

# Make readonly again
mount -ur $VOLUME

echo "Done. Shadowfile can be found on your SD-card in the Dump-folder."

exit 0
