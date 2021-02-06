#!/bin/sh

#info
TOPIC=Hosts
DESCRIPTION="This script will dump the hosts file."

#Volumes/files
FILENAME=hosts
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
DUMPFOLDER="$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC"

echo Dump-folder: $DUMPFOLDER
mkdir -p $VOLUME/Dump/$VERSION/$FAZIT/$TOPIC
echo Dumping, please wait.
sleep 1

echo Copying hosts file to SD-card.
cp /$ORIGINAL/$FILENAME $DUMPFOLDER/hosts.txt

#show contents
echo Listing file:
sleep .5

cat $DUMPFOLDER/hosts.txt

# Make readonly again
mount -ur $VOLUME

echo "Done. Hostsfile can be found on your SD-card in the Dump-folder."

exit 0
