#!/bin/sh
SCRIPTDIR=$( cd -P -- "$(dirname -- "$(command -v -- "$_")")" && pwd -P )

#info
TOPIC=Firewall
DESCRIPTION="This script will dump the pf (firewall) config."

#Volumes/files
FILENAME=pf.conf
ORIGINAL=/net/mmx/mnt/system/etc/

echo $DESCRIPTION

. ${SCRIPTDIR}/util_info.sh
. ${SCRIPTDIR}/util_mountsd.sh
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

echo Copying ${FILENAME} file to SD-card.
cp $ORIGINAL/$FILENAME $DUMPFOLDER/${FILENAME}

#show contents
echo Listing file:
sleep .5

cat $DUMPFOLDER/${FILENAME}

# Make readonly again
mount -ur $VOLUME

echo "Done. ${FILENAME} can be found on your SD-card in the Dump-folder."

exit 0
