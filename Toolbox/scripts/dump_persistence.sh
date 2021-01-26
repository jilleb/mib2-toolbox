#!/bin/sh

#info
TOPIC=Persistence
DESCRIPTION="This script will dump the persistence database"

#Volumes/files
ORIGINAL=/var/fw/persistence.sqlite

echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

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
