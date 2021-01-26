#!/bin/sh

#info
TOPIC=FEC
DESCRIPTION="This script will dump the FEC folder"

#Volumes/files
ORIGINAL=/net/rcc/mnt/efs-persist/FEC

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
cp -R $ORIGINAL $DUMPFOLDER
ls -R $DUMPFOLDER > $DUMPFOLDER/files.txt

sleep 1

echo Listing all files:
sleep .5

cat $DUMPFOLDER/files.txt

rm $DUMPFOLDER/files.txt

# Make readonly again
mount -ur $VOLUME

echo "Done. FEC dump can be found in the Dump folder on your SD-card"

exit 0
