#!/bin/sh

#info
TOPIC=Shadowfile
DESCRIPTION="This script will replace the shadow file with the shadow file in Custom/Shadowfile/shadow.txt."

#Volumes/files
VOLUME=/fs/sda0
FILENAME=shadow
ORIGINAL=/net/mmx/mnt/system/etc/
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

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app
mount -uw /mnt/system

if [ -f $VOLUME/Custom/Shadowfile/shadow.txt ]; then
    echo "New shadow.txt file found"

    echo Mounting SD-card.
    mount -uw $VOLUME
    mount -uw /net/mmx/mnt/system/

    sleep .5

    #Make backup folder
    DUMPFOLDER="$VOLUME/Backup/$VERSION/$FAZIT/$TOPIC"

    echo Backup-folder: $DUMPFOLDER

    echo Making a backup, please wait.

    mkdir -p $DUMPFOLDER

    echo Copying shadow file to SD-card.
    cp /$ORIGINAL/$FILENAME $DUMPFOLDER/shadow.txt

    #show contents
    echo "Original shadow file:"
    sleep 1
    cat $DUMPFOLDER/shadow.txt
    sleep 1

    echo
    echo "Copy new shadow file"
    cp $VOLUME/Custom/Shadowfile/shadow.txt /$ORIGINAL/$FILENAME 
    
    # Make readonly again
    mount -ur $VOLUME
    mount -ur /net/mmx/mnt/system/
    
    echo "Done. Backup can be found on your SD-card."
    echo "shadow file replaced, new password is now active."

else 
    echo "No shadowfile found at /Custom/Shadowfile/shadow.txt"
    exit 0
fi

exit 0
