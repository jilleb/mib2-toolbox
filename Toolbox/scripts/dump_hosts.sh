#!/bin/sh

#info
TOPIC=Hosts
DESCRIPTION="This script will dump the hosts file."

#Volumes/files
FILENAME=hosts
ORIGINAL=/net/mmx/mnt/system/etc/

echo $DESCRIPTION

. /eso/bin/PhoneCustomer/default/util_info.sh

. /eso/bin/PhoneCustomer/default/util_mountsd.sh
if [[ -z "$VOLUME" ]] 
then
	echo "No SD-card found, quitting"
	exit 0
fi

#Make backup folder
DUMPFOLDER="$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC"

echo Dump-folder: $DUMPFOLDER

echo Dumping, please wait. This can take a while.

mkdir -p $VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Copying shadow file to SD-card.
cp /$ORIGINAL/$FILENAME $DUMPFOLDER/hosts.txt

#show contents
cat $DUMPFOLDER/hosts.txt

# Make readonly again
mount -ur $VOLUME

echo "Done. Hostsfile can be found on your SD-card in the Dump-folder."

exit 0
