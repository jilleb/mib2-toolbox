#!/bin/sh

#info
TOPIC=IFS
DESCRIPTION="This script will dump the ifs-root."

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION
echo "---------------------------"
sleep .5


#Is there any SD-card inserted?
if [ -d /net/mmx/fs/sda0 ]; then
    echo SDA0 found
    VOLUME=/net/mmx/fs/sda0
elif [ -d /net/mmx/fs/sdb0 ] ; then
    echo SDB0 found
    VOLUME=/net/mmx/fs/sdb0
else 
    echo No SD-cards found.
    exit 0
fi

sleep .5

echo Mounting SD-card.
mount -uw $VOLUME

sleep .5

#Make backup folder
DUMPFOLDER=$VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

echo Dump-folder: $DUMPFOLDER

mkdir -p $DUMPFOLDER
echo "Please wait while the file is dumped"
echo "It will appear like nothing is happening."
sleep 1
echo
echo "Dumping, this will take a while. Please be patient."

cat /net/rcc/dev/fs0 > $DUMPFOLDER/ifs_dump.bin

# Make readonly again
mount -ur $VOLUME

echo "Done. IFS-root dump can be found in the Dump folder on your SD-card"

exit 0
