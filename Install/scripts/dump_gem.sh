#!/bin/sh

#info
TOPIC=GEM
DESCRIPTION="This script will dump GEM.jar"

#Volumes/files
ORIGINAL=/eso/hmi/lsd/jars/GEM.jar

echo $DESCRIPTION


. /eso/bin/PhoneCustomer/default/util_info.sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /mnt/system


#Make backup folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER

echo Dumping, please wait. This can take a while.

mkdir -p $DUMPFOLDER


echo Copying files
cp $ORIGINAL $DUMPFOLDER

sleep 1

# Make readonly again
mount -ur /net/mmx/fs/sda0

echo "Done. GEM dump can be found in the Dump folder on your SD-card"

exit 0
