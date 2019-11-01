#!/bin/sh

#info
TOPIC=Shadowfile
DESCRIPTION="This script will replace the shadow file with the shadow file in Advanced/Shadowfile/shadow.txt."

#Volumes/files
VOLUME=/fs/sda0
FILENAME=shadow
ORIGINAL=/net/mmx/mnt/system/etc/

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION
echo "---------------------------"
sleep .5

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /mnt/system

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

if [ -f $VOLUME/Advanced/Shadowfile/shadow.txt ]; then
    echo "New shadow.txt file found"

    echo Mounting SD-card.
    mount -uw $VOLUME
    mount -uw /net/mmx/mnt/system/

    sleep .5

    #Make backup folder
    DUMPFOLDER="$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC"

    echo Backup-folder: $DUMPFOLDER

    echo Making a backup, please wait.

    mkdir -p $VOLUME/Dump/$VERSION/$FAZIT/$TOPIC

    echo Copying shadow file to SD-card.
    cp /$ORIGINAL/$FILENAME $DUMPFOLDER/shadow.txt

    #show contents
    echo "Original shadow file:"
    sleep 1
    cat $DUMPFOLDER/shadow.txt
    sleep 1

    echo
    echo "Copy new shadow file"
    cp $VOLUME/Advanced/Shadowfile/shadow.txt /$ORIGINAL/$FILENAME 
    
    # Make readonly again
    mount -ur $VOLUME
    mount -ur /net/mmx/mnt/system/
    
    echo "Done. Backup can be found on your SD-card."
    echo "shadow file replaced, new password is now active."

else 
    echo "No shadowfile found at /Advanced/Shadowfile/shadow.txt"
    exit 0
fi

exit 0
