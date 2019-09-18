#!/bin/sh

#info
TOPIC=GreenMenu
DESCRIPTION="This script will copy custom ESD(Green Menu) files from GreenMenu folder on your SD to the unit."

#Firmware/unit info:
VERSION="$(cat /net/rcc/dev/shmem/version.txt | grep "Current train" | sed 's/Current train = //g' | sed -e 's|["'\'']||g' | sed 's/\r//')"
FAZIT=$(cat /tmp/fazit-id);

echo "---------------------------"
echo $DESCRIPTION
echo FAZIT of this unit: $FAZIT
echo Firmware version: $VERSION
echo "---------------------------"
echo ""
sleep .5

#Make app volume writable
echo Mounting app folder.
mount -uw /mnt/app

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

cp $VOLUME/$TOPIC/*.esd /eso/hmi/engdefs/
cp $VOLUME/$TOPIC/scripts/*.sh /eso/hmi/engdefs/scripts/
chmod a+rwx /eso/hmi/engdefs/scripts/*


# Make readonly again
mount -ur /mnt/app
mount -ur $VOLUME

echo Done. Please restart green menu.

exit 0
