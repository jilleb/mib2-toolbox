#!/bin/sh

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

SDPATH=$VOLUME/Advanced/FEC/FecContainer.fec
FECPATH=/net/rcc/mnt/efs-persist/FEC/FecContainer.fec


if test -f "$SDPATH"; then
    # Make volume writable
    mount -uw /net/rcc/mnt/efs-persist
    echo "Copying FecContainer.fec"
    cp -f $SDPATH $FECPATH
    # Make readonly again
    mount -ur /net/rcc/mnt/efs-persist
    
    sleep 1
    echo "FecContainer.fec copied"
    echo "Done"
else
    echo "FecContainer.fec not found at sda0/Advanced/FEC/"
    exit 0
fi

exit 0
