#!/bin/sh

#info
TOPIC=Persistence
DESCRIPTION="This script will dump the persistence database"

#Volumes/files
VOLUME=/fs/sda0
ORIGINAL=/var/fw/persistence.sqlite

echo $DESCRIPTION

#include script to show and set unit info to variables $FAZIT and $VERSION
. /eso/bin/PhoneCustomer/default/util_info.sh

#include script to mount the sd-card and set variable $VOLUME as the SD-location
. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi


#Make backup folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER

echo Dumping, please wait. This can take a while.

mkdir -p $DUMPFOLDER


echo Copying files
cp -R $ORIGINAL $DUMPFOLDER

sleep 1

# Make readonly again
mount -ur $VOLUME

echo "Done. Persistence.sqlite dump can be found in the Dump folder on your SD-card"

exit 0
